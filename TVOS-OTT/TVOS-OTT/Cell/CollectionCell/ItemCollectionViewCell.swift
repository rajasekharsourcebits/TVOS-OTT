//
//  ItemCollectionViewCell.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import ParallaxView

class ItemCollectionViewCell: ParallaxCollectionViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    
    fileprivate var widthToHeightRatio = CGFloat(0)
    
    func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        widthToHeightRatio = round(((bounds.width * 0.08 + bounds.height)/bounds.height)*100)/100
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
}
