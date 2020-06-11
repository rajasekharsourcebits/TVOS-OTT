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
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesViewModel.callApi(view: self.view)
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
