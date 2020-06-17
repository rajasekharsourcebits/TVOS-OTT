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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FromHome" {
            if let vc = segue.destination as? CommonVC {
                vc.tabSelected = tabSelected
            }
        }
    }
}

extension HomeViewController {
    
    fileprivate func setNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.black.cgColor
        context.nextFocusedView?.layer.shadowOpacity = 1
        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
        context.nextFocusedView?.layer.shadowRadius = 5
        context.nextFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }
    
    fileprivate func setPrevioulyFocusedUI(_ context: UIFocusUpdateContext) {
        context.previouslyFocusedView?.layer.shadowColor = UIColor.clear.cgColor
        context.previouslyFocusedView?.layer.shadowOpacity = 0
        context.previouslyFocusedView?.layer.shadowOffset = CGSize.zero
        context.previouslyFocusedView?.layer.shadowRadius = 0
        context.previouslyFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        guard context.nextFocusedView != nil else {
            return
        }
        setNextFocusUI(context)
        setPrevioulyFocusedUI(context)
        //removeChildIfNead()
    }
}

