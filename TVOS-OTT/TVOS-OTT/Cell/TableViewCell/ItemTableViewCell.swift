//
//  ItemTableViewCell.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import SDWebImage

class ItemTableViewCell: UITableViewCell {
    var viewModel = CommonVCViewModel(provider: ServiceProvider<UserService>())
    var model: [ListItems]?
    var tvModelData: [TVShowsItem]?
    var tabSelected: String?
    var myVC: UIViewController?
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.remembersLastFocusedIndexPath = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension ItemTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tabSelected == "TVShows" {
            return tvModelData?.count ?? 0
        } else {
            return model?.count ?? 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell {
            cell.layer.cornerRadius = 10.0
            cell.clipsToBounds = true
            configerCell(cell: cell, withIndex: indexPath.item, section: indexPath.section)
            return cell
        } else {
            return ItemCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        if tabSelected == "TVShows" {
             vc?.viewModel.detailID = tvModelData?[indexPath.item].id
        } else {
            vc?.viewModel.detailID = model?[indexPath.item].id
        }
           
        if let vc = vc {
            if let myVC = myVC {
                myVC.present(vc , animated: true, completion: nil)
            }
            
        }
    }
    
}

extension ItemTableViewCell {
    fileprivate func getPath(_ withIndex: Int, section: Int) -> String {
        if tabSelected == "TVShows" {
            if let path = tvModelData?[withIndex].image {
                return path
            } else {
                return Constants.noImageUrl
            }
        } else {
            if let path = model?[withIndex].image {
                return path
            } else {
                return Constants.noImageUrl
            }
        }
        
    }
    
    fileprivate func setImage(_ withIndex: Int, _ cell: ItemCollectionViewCell, section: Int) {
        let path = getPath(withIndex, section: section)
        if path == "" {
            cell.itemImage.downloadImageFrom(url: Constants.noImageUrl, contentMode: .scaleToFill)
        } else {
            let imageUrl = URL.init(string: path)
            if let imageUrl = imageUrl {
                cell.itemImage.sd_setImage(with: imageUrl, completed: nil)
                cell.itemImage.adjustsImageWhenAncestorFocused = true
            }
        }
//        cell.itemImage.downloadImageFrom(url: Constants.noImageUrl, contentMode: .scaleToFill)
    }
    
    func configerCell(cell: ItemCollectionViewCell, withIndex: Int, section: Int) {
        DispatchQueue.main.async {
            self.setImage(withIndex, cell, section: section)
        }
        
    }
}
