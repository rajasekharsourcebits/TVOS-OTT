//
//  UIViewcontroller+Extesnion.swift
//  TVOS-OTT
//
//  Created by Souvik on 22/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func setNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.white.cgColor
        context.nextFocusedView?.layer.shadowOpacity = 0.2
        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
        context.nextFocusedView?.layer.shadowRadius = 3
        context.nextFocusedView?.layer.cornerRadius = 10
        context.nextFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }
    
    func setPrevioulyFocusedUI(_ context: UIFocusUpdateContext) {
        context.previouslyFocusedView?.layer.shadowColor = UIColor.clear.cgColor
        context.previouslyFocusedView?.layer.shadowOpacity = 0
        context.previouslyFocusedView?.layer.shadowOffset = CGSize.zero
        context.previouslyFocusedView?.layer.shadowRadius = 0
        context.previouslyFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
    }
    
    func setButtonNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.white.cgColor
        context.nextFocusedView?.layer.shadowOpacity = 1
        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
        context.nextFocusedView?.layer.shadowRadius = 5
        context.nextFocusedView?.backgroundColor = #colorLiteral(red: 0, green: 0.3620362878, blue: 0.6688420177, alpha: 1)
        //let value = context.previouslyFocusedView?.subviews.first
        
        if let button = context.nextFocusedView as? UIButton {
            button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
        context.nextFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }
    
    func setButtonPrevioulyFocusedUI(_ context: UIFocusUpdateContext) {
        context.previouslyFocusedView?.layer.shadowColor = UIColor.clear.cgColor
        context.previouslyFocusedView?.layer.shadowOpacity = 0
        context.previouslyFocusedView?.layer.shadowOffset = CGSize.zero
        context.previouslyFocusedView?.layer.shadowRadius = 0
        context.previouslyFocusedView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if let button = context.previouslyFocusedView as? UIButton {
            button.setTitleColor(#colorLiteral(red: 0, green: 0.3620362878, blue: 0.6688420177, alpha: 1), for: .normal)
        }
    }
}
