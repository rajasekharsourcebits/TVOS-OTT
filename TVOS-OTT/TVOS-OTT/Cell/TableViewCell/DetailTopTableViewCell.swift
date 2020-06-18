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
    
    var myVC: UIViewController?
    
    var list: [Similar]?
    
    var sectionIndex: Int?
    var type: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.remembersLastFocusedIndexPath = true
        
        let layout = UICollectionViewFlowLayout()
        
        let inset = CGFloat(430) * 0.1
        
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.itemSize = CGSize(width: 430, height: 250)
        layout.minimumInteritemSpacing = 20
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension DetailTopTableViewCell {
    
    @discardableResult
    func set(withData sectionIndex: Int?, list: [Similar]?, myVC: UIViewController?, type: String?) -> Self {
        
        if let sectionIndex = sectionIndex {
            self.sectionIndex = sectionIndex
        }
        
        if let type = type {
            self.type = type
        }
        
        if let list = list {
            self.list = list
            collectionView.reloadData()
        }
        
        if let myVC = myVC {
            self.myVC = myVC
        }
        
        return self
    }
}

extension DetailTopTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let value = list {
            return value.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell {
            cell.itemImage.layer.cornerRadius = 20
            cell.layer.cornerRadius = 20
            if let image = list?[indexPath.row].image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    cell.itemImage.sd_setImage(with: imageUrl, completed: nil)
                    
                }
            }
            
            return cell
        } else {
            return ItemCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        print(context.nextFocusedIndexPath?.item ?? 0)
        
        
        if let type = type {
            if type == "Movie" {
                if sectionIndex == 0 {
                    if let cell = context.previouslyFocusedView as? ItemCollectionViewCell {
                        cell.playImageView.isHidden = true
                        cell.playImageView.alpha = 0
                    }
                    
                    if let cell = context.nextFocusedView as? ItemCollectionViewCell {
                        cell.playImageView.isHidden = false
                        cell.playImageView.alpha = 0.6
                    }
                    
                }
            } else {
                if sectionIndex == 1 {
                    if let cell = context.previouslyFocusedView as? ItemCollectionViewCell {
                        cell.playImageView.isHidden = true
                        cell.playImageView.alpha = 0
                    }
                    
                    if let cell = context.nextFocusedView as? ItemCollectionViewCell {
                        cell.playImageView.isHidden = false
                        cell.playImageView.alpha = 0.6
                    }
                }
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
        
        if let type = type {
            if type == "Movie" {
                if sectionIndex == 0 {
                    let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "MinimizedPlayerVC") as? MinimizedPlayerVC
                    if let vc = vc {
                        if let myVC = myVC {
                            myVC.present(vc , animated: true, completion: nil)
                        }
                        
                    }
                } else {
                    let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
                    vc?.viewModel.detailID = list?[indexPath.item].id
                    if let vc = vc {
                        if let myVC = myVC {
                            myVC.present(vc , animated: true, completion: nil)
                        }
                        
                    }
                }
            } else {
                if sectionIndex == 1 {
                    let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "MinimizedPlayerVC") as? MinimizedPlayerVC
                    if let vc = vc {
                        if let myVC = myVC {
                            myVC.present(vc , animated: true, completion: nil)
                        }
                        
                    }
                } else {
                    let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
                    vc?.viewModel.detailID = list?[indexPath.item].id
                    if let vc = vc {
                        if let myVC = myVC {
                            myVC.present(vc , animated: true, completion: nil)
                        }
                        
                    }
                }
            }
        } else {
            let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            vc?.viewModel.detailID = list?[indexPath.item].id
            if let vc = vc {
                if let myVC = myVC {
                    myVC.present(vc , animated: true, completion: nil)
                }
                
            }
        }
    }
    
}
