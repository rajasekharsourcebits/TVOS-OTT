//
//  Reachability.swift
//  TVOS-OTT
//
//  Created by Souvik on 26/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation
import Reachability

//Reachability
//declare this property where it won't go out of scope relative to your listener
fileprivate var reachability: Reachability!

protocol ReachabilityActionDelegate {
    func reachabilityChanged(_ isReachable: Bool)
}

protocol ReachabilityObserverDelegate: class, ReachabilityActionDelegate {
    func addReachabilityObserver() throws
    func removeReachabilityObserver()
    
}

// Declaring default implementation of adding/removing observer
extension ReachabilityObserverDelegate {
    
    /** Subscribe on reachability changing */
    func addReachabilityObserver() throws {
        reachability = try Reachability()
        
        reachability.whenReachable = { [weak self] reachability in
            self?.reachabilityChanged(true)
        }
        
        reachability.whenUnreachable = { [weak self] reachability in
            self?.reachabilityChanged(false)
        }
        
        try reachability.startNotifier()
    }
    
    /** Unsubscribe */
    func removeReachabilityObserver() {
        reachability.stopNotifier()
        reachability = nil
    }
}

protocol ReachableExpose: class {
    func reachabilityChanged(_ isReachable: Bool)
}
class ReachabilityHandler: ReachabilityObserverDelegate {
    
    //MARK: Lifecycle
    
    required init() {
        try? addReachabilityObserver()
    }
    
    deinit {
        removeReachabilityObserver()
    }
    
    //MARK: Reachability
    var reachableExposeDelegate: ReachableExpose?
    func reachabilityChanged(_ isReachable: Bool) {
        if isReachable {
            print("Internet connection available...")
            reachableExposeDelegate?.reachabilityChanged(isReachable)
        } else {
             print("No internet connection")
            reachableExposeDelegate?.reachabilityChanged(isReachable)
        }
}
}

extension UIView {
    
    func showToast(message : String, font: UIFont) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.frame.size.width/2 - 75, y: self.frame.size.height-100, width: 150, height: 55))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}
