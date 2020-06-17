//
//  NetworkConstants.swift
//  TVOS-OTT
//
//  Created by Souvik on 26/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    //key = k_Q0iHYBj6
    struct Holder {
        
        static var baseUrl: String = "https://imdb-api.com/en/API/"
        
    }
    
    var baseUrl: String {
        get {
            return Holder.baseUrl
        }
    }
}

extension Constants {
    
//    static var key: String = "/k_Q0iHYBj6" /// S mail
//    static var key: String = "/k_5m6495hW" /// K mail
    static var key: String = "/k_l3228Cbz" /// Office mail
    
    static var mostPopularMovies: String = "MostPopularMovies"
    static var mostPopularTVs: String = "MostPopularTVs"
    static var inTheaters: String = "InTheaters"
    static var comingSoon: String = "ComingSoon"
    static var boxOffice: String = "BoxOffice"
    static var boxOfficeAllTime: String = "BoxOfficeAllTime"
    static var movies250: String = "Top250Movies"
    static var tvshow250: String = "Top250TVs"
    static var searchAll: String = "SearchAll"
    static var expression: String = ""
    static var detail: String = "Title"
    static var castcrew: String = "Name"
    static var noImageUrl: String = "https://imdb-api.com/images/original/nopicture.jpg"
}

enum StoryboardHelper: String {
    
    case main = "Main"

    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type, function: String = #function, line: Int = #line, file: String = #file) -> T {
        
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        
        guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {
            
            fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
        }
        
        return scene
    }
    
    func initialViewController() -> UIViewController? {
        
        return instance.instantiateInitialViewController()
    }
}

extension UIViewController {
    
    class var storyboardID: String {
           
           return "\(self)"
       }
    static func instantiate(fromAppStoryboard appStoryboard: StoryboardHelper) -> Self {
           return appStoryboard.viewController(viewControllerClass: self)
       }
}

