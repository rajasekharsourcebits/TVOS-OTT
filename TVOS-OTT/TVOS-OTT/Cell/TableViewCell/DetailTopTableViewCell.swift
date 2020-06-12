//
//  DetailTopTableViewCell.swift
//  TVOS-OTT
//
//  Created by Souvik on 10/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class DetailTopTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presetIndex: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.remembersLastFocusedIndexPath = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension DetailTopTableViewCell {
    
    @discardableResult
    func set(withData sectionIndex: Int?) -> Self {
        
        if let sectionIndex = sectionIndex {
            presetIndex = sectionIndex
        }
        return self
    }
}

extension DetailTopTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let value = presetIndex {
            switch  value{
            case 0:
                return 10
            case 1:
                return 1
            default:
                return 9
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell {
            cell.itemImage.layer.cornerRadius = 10.0
            cell.itemImage.clipsToBounds = true
            return cell
        } else {
            return ItemCollectionViewCell()
        }
    }
    
    
}
