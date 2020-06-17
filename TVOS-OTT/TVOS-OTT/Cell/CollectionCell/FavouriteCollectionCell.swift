//
//  FavouriteCollectionCell.swift
//  TVOS-OTT
//
//  Created by Souvik on 01/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import ParallaxView

class FavouriteCollectionCell: ParallaxCollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    
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
