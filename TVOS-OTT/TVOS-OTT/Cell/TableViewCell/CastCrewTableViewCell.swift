//
//  CastCrewTableViewCell.swift
//  TVOS-OTT
//
//  Created by Souvik on 11/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class CastCrewTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var referenceVC: UIViewController?
    
    var list: [ActorList]?
    
    
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
    
    func refreshList() {
        collectionView.reloadData()
    }

}

extension CastCrewTableViewCell {
    
    @discardableResult
    func set(withData sectionIndex: Int?, list: [ActorList]?) -> Self {
        
//        if let sectionIndex = sectionIndex {
//            presetIndex = sectionIndex
//        }
        
        if let list = list {
            self.list = list
        }
        refreshList()
        
        return self
    }
}

extension CastCrewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let list = list {
            return list.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCrewCollectionViewCell", for: indexPath) as? CastCrewCollectionViewCell {
            
            if let image = list?[indexPath.row].image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    cell.crewImage.sd_setImage(with: imageUrl,  placeholderImage:UIImage(named : ""), completed: nil)
                    
                }
            } else {
                cell.crewImage.adjustsImageWhenAncestorFocused = true
                cell.crewImage.image = UIImage(named: "")
            }
            cell.nameLbl.text = list?[indexPath.row].name
            cell.crewImage.layer.cornerRadius = 81.5
            return cell
        } else {
            return CastCrewCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 316)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 40

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "CastCrewDetailViewController") as? CastCrewDetailViewController
        vc?.viewModel.detailID = list?[indexPath.row].id
        if let vc = vc, let myVC = referenceVC {
            myVC.present(vc , animated: true, completion: nil)
        }
    }
    
    
}
