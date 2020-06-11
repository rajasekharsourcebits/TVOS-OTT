//
//  TVShowsViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class TVShowsViewController: UIViewController {
    let viewModel = TVShowsViewModel(provider: ServiceProvider<UserService>())
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.callApi(view: self.view)
    }
}
