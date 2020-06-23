//
//  HomeViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    var tabSelected: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // Pass selected tab title through segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromHome" {
            if let vc = segue.destination as? CommonVC {
                vc.tabSelected = tabSelected
            }
        }
    }
}


