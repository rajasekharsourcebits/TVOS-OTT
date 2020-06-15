//
//  SearchViewModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 03/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation
import UIKit
protocol SearchViewModelDelegate: class {
    func updateUI()
}

class SearchViewModel {
    
    var provider:ServiceProvider<UserService>
    var reachable = ReachabilityHandler()
    var isReachable: Bool?
    var view: UIView?
    weak var searchViewModelDelegate: SearchViewModelDelegate?
    var searchModel: ResultSearch? {
        willSet{
            
        }
        didSet {
            searchViewModelDelegate?.updateUI()
        }
    }
    init(provider: ServiceProvider<UserService>) {
        self.provider = provider
        reachable.reachableExposeDelegate = self
    }
}

//MARK:- Reachable Methods
extension SearchViewModel: ReachableExpose {
    
    func callApi(view: UIView) {
        self.view = view
        if isReachable ?? true {
            callSearchData(view: view)
        } else {
            view.showToast(message: "oops it seems you are offline", font:  UIFont(name: "GillSans-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 9))
        }
    }
    
    func reachabilityChanged(_ isReachable: Bool) {
        if isReachable {
            // print("Internet connection available...")
            self.isReachable = isReachable
            
        } else {
            self.isReachable = isReachable
            // print("No internet connection")
        }
    }
}

//MARK:- Api Call
extension SearchViewModel {
    private func callSearchData(view: UIView) {
        view.showSpinner(onView: view)
        provider.load(service: .searchAll, decodeType: ResultSearch.self) { result in
            view.removeSpinner()
            switch result {
            case .success(let resp):
                self.searchModel = resp
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showToast(message: error.localizedDescription, font:  UIFont(name: "GillSans-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 9))
            case .empty:
                print("No Data")
                self.view?.showToast(message: "No Data", font:  UIFont(name: "GillSans-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 9))
            }
            Constants.expression = ""
        }
    }
}
//MARK:- Helper Methods
extension SearchViewModel {
    func numbareOfSessions() -> Int {
        return searchModel?.results?.count ?? 0
    }
    func setSessionTitle(index: Int) -> String {
        return searchModel?.results?[index].title ?? "--"
    }
}

//MARK:- Helper Methods
extension SearchViewModel {
    func numbareOfItems() -> Int {
        return searchModel?.results?.count ?? 0
    }
    
    fileprivate func setTitle(_ withIndex: Int, _ cell: SearchCollectionViewCell) {
        if let title = searchModel?.results?[withIndex].title {
            cell.name.text = title
        } else {
            cell.name.text = "--"
        }
    }
    
    fileprivate func getPath(_ withIndex: Int) -> String{
        if let path = searchModel?.results?[withIndex].image {
            return path
        } else {
            return Constants.noImageUrl
        }
    }
    
    fileprivate func setImage(_ withIndex: Int, _ cell: SearchCollectionViewCell) {
        let path = getPath(withIndex)
        if path == "" {
            cell.banner.downloadImageFrom(url: Constants.noImageUrl, contentMode: .scaleToFill)
        } else {
            let imageUrl = URL.init(string: path)
            if let imageUrl = imageUrl {
                cell.banner.sd_setImage(with: imageUrl, completed: nil)
            }
        }
    }
    
    func configerCell(cell: SearchCollectionViewCell, withIndex: Int) {
        setTitle(withIndex, cell)
        setImage(withIndex, cell)
    }
    
}



