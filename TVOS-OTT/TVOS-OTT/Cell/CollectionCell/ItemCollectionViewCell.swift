//
//  ItemCollectionViewCell.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import ParallaxView

// Adding parallex effect to uiview use collectionView sub Class.

class ItemCollectionViewCell: ParallaxCollectionViewCell {
    
    //UI Property
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var playImageView: UIImageView!
    
    func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
}
