//
//  CastCrewViewModel.swift
//  TVOS-OTT
//
//  Created by Souvik on 15/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation

import UIKit
protocol CastCrewDelegate: class {
    func updateUI()
}

class CastCrewViewModel {
    
    // Variables
    var detailID: String?
    var provider:ServiceProvider<UserService>
    var reachable = ReachabilityHandler()
    var isReachable: Bool?
    var view: UIView?
    weak var delegate: CastCrewDelegate?
    var model: castCrewModel? {
        willSet{
            
        }
        didSet {
            delegate?.updateUI()
        }
    }
    init(provider: ServiceProvider<UserService>) {
        self.provider = provider
        reachable.reachableExposeDelegate = self
    }
}

//MARK:- Reachable Methods
extension CastCrewViewModel: ReachableExpose {
    
    func callApi(view: UIView) {
       self.view = view
        if isReachable ?? true {
            callSearchData(view: view)
        } else {
            view.showToast(message: "oops it seems you are offline", font:  UIFont(name: "GillSans-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 9))
        }
    }
    
    //Network Avability check
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
extension CastCrewViewModel {
    private func callSearchData(view: UIView) {
        
        Constants.expression = detailID ?? ""
        view.showSpinner(onView: view)
        provider.load(service: .CastCrewDetail, decodeType: castCrewModel.self) { result in
            view.removeSpinner()
            switch result {
            case .success(let resp):
                self.model = resp
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
