//
//  MoviesViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    let moviesViewModel = MoviesViewModel(provider: ServiceProvider<UserService>())
    
    var commonVC = CommonVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModel.moviesViewModelDelegate = self
//        moviesViewModel.callApi(view: self.view)

    }
}

extension MoviesViewController: MoviesViewModelDelegate {
    func updateUI() {
//        commonVC.viewModel.bannerList = moviesViewModel.moviesModel?.items
    }
    
    
}
