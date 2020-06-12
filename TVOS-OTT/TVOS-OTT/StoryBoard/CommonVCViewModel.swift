//
//  CommonVCViewModel.swift
//  TVOS-OTT
//
//  Created by Kiran on 11/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation
import UIKit

protocol CommonVCModelDelegate: class {
    func updateUI()
}

class CommonVCViewModel {
    var provider:ServiceProvider<UserService>
    var reachable = ReachabilityHandler()
    var isReachable: Bool?
    var view: UIView?
    weak var commonVCModelDelegate: CommonVCModelDelegate?

    var data: HomeResult? {
        willSet{
            
        }
        didSet {
            commonVCModelDelegate?.updateUI()
        }
    }
    
    init(provider: ServiceProvider<UserService>) {
        self.provider = provider
        reachable.reachableExposeDelegate = self
    }
}


//MARK:- Reachable Methods
extension CommonVCViewModel: ReachableExpose {
    
    func callApi(view: UIView, serviceType: UserService) {
       self.view = view
        if isReachable ?? true {
            callTop250Movies(view: view, serviceType: serviceType)
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
extension CommonVCViewModel {
    private func callTop250Movies(view: UIView, serviceType: UserService) {
        view.showSpinner(onView: view)
        provider.load(service: serviceType, decodeType: HomeResult.self) { result in
            view.removeSpinner()
            switch result {
            case .success(let resp):
                self.data = resp
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






