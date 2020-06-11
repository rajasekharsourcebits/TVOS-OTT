//
//  MoviesViewModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 10/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation
import UIKit
protocol MoviesViewModelDelegate: class {
    func updateUI()
}

class MoviesViewModel {
    
    var provider:ServiceProvider<UserService>
    var reachable = ReachabilityHandler()
    var isReachable: Bool?
    var view: UIView?
    weak var moviesViewModelDelegate: MoviesViewModelDelegate?
    var moviesModel: ResultMovies? {
        willSet{
            
        }
        didSet {
            moviesViewModelDelegate?.updateUI()
        }
    }
    init(provider: ServiceProvider<UserService>) {
        self.provider = provider
        reachable.reachableExposeDelegate = self
    }
}

//MARK:- Reachable Methods
extension MoviesViewModel: ReachableExpose {
    
    func callApi(view: UIView) {
       self.view = view
        if isReachable ?? true {
            callMovieData(view: view)
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
extension MoviesViewModel {
    private func callMovieData(view: UIView) {
        view.showSpinner(onView: view)
        provider.load(service: .top250movies, decodeType: ResultMovies.self) { result in
            view.removeSpinner()
            switch result {
            case .success(let resp):
                self.moviesModel = resp
            case .failure(let error):
                print(error.localizedDescription)
                self.view?.showToast(message: error.localizedDescription, font:  UIFont(name: "GillSans-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 9))
            case .empty:
                print("No Data")
                self.view?.showToast(message: "No Data", font:  UIFont(name: "GillSans-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 9))
            }
        }
    }
}
//MARK:- Helper Methods
extension MoviesViewModel {
//    func numbareOfSessions() -> Int {
//         return moviesModel?.results?.count ?? 0
//    }
//    func setSessionTitle(index: Int) -> String {
//        return moviesModel?.results?[index].title ?? "--"
//    }
}

//MARK:- Helper Methods
extension MoviesViewModel {
    func numbareOfItems() -> Int {
        return moviesModel?.items.count ?? 0
    }
//
//    fileprivate func setTitle(_ withIndex: Int, _ cell: ItemCollectionViewCell) {
//        if let title = moviesModel?.items[withIndex].title {
//            cell.name.text = title
//        } else {
//            cell.name.text = "--"
//        }
//    }

    fileprivate func getPath(_ withIndex: Int) -> String{
        if let path = moviesModel?.items[withIndex].image {
             return path
        } else {
            return Constants.noImageUrl
        }
    }

    fileprivate func setImage(_ withIndex: Int, _ cell: ItemCollectionViewCell) {
        let path = getPath(withIndex)
        if path == "" {
           cell.itemImage.downloadImageFrom(url: Constants.noImageUrl, contentMode: .scaleAspectFit)
        } else {
            cell.itemImage.downloadImageFrom(url: path, contentMode: .scaleAspectFit)
        }
    }

    func configerCell(cell: ItemCollectionViewCell, withIndex: Int) {
//        setTitle(withIndex, cell)
        setImage(withIndex, cell)
    }
    
}
