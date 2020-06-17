//
//  TabViewController.swift
//  TVOS-OTT
//
//  Created by Kiran on 16/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = self.viewControllers![0] as? HomeViewController
        homeVC?.temp = "Home"
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
       
        let homeVC = self.viewControllers![0] as? HomeViewController
        homeVC?.temp = "Home"
        
        let tVShowsVC = self.viewControllers![1] as? TVShowsViewController
        tVShowsVC?.temp = "TVShows"
        
        let moviesVC = self.viewControllers![2] as? MoviesViewController
        moviesVC?.temp = "Movies"
        
    }
    
    

}
