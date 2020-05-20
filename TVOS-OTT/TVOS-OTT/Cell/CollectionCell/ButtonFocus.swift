//
//  ButtonFocus.swift
//  TVOS-OTT
//
//  Created by Kiran on 20/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class ButtonFocus: UIButton {
    
    func canBecomeFocused() -> Bool {
        return true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedView === self {
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                context.nextFocusedView?.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
            })
        }
        
        if context.previouslyFocusedView === self {
            UIView.animate(withDuration: 0.1, animations: {() -> Void in
                context.previouslyFocusedView?.transform = CGAffineTransform(scaleX: 1.10, y: 1.10)
            })
        }
    }
    
}

