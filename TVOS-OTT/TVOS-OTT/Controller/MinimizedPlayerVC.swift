//
//  MinimizedPlayerVC.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class MinimizedPlayerVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureFlowLayoutSpacing()
    }
    
    func configureFlowLayoutSpacing() {
        let layout = UICollectionViewFlowLayout()
        
        let inset = CGFloat(400) * 0.1
        
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.itemSize = CGSize(width: 430, height: 250)
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
    }



}

extension MinimizedPlayerVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionCell", for: indexPath) as? FavouriteCollectionCell {
            cell.imgView.layer.cornerRadius = 10

//            if let image = favList[indexPath.row].image {
//                let imageUrl = URL.init(string: image)
//                if let imageUrl = imageUrl {
//                    cell.imgView.sd_setImage(with: imageUrl, completed: nil)
//                }
//            }
            //cell.imgView.adjustsImageWhenAncestorFocused = true
            return cell
        } else {
            return FavouriteCollectionCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        // test
        //print("Previous Focused Path: \(context.previouslyFocusedIndexPath)")
        //print("Next Focused Path: \(context.nextFocusedIndexPath)")
        
//        if let value = context.nextFocusedIndexPath {
//            // let item = lis[value.first ?? 0].cards?[value.last ?? 0]
//            print(value)
//            let item = favList[value.last ?? 0]
//            currentselectedIndex = value.last ?? 0
//            nameLbl.text = item.name
//            descLbl.text = item.desc
//
//            if let image = item.image {
//                let imageUrl = URL.init(string: image)
//                if let imageUrl = imageUrl {
//                    posterImage.sd_setImage(with: imageUrl, completed: nil)
//                    imgView.sd_setImage(with: imageUrl, completed: nil)
//                }
//            }
//        }
        
    }
    
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: 0, section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
//        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
//        vc?.viewModel.detailID = favList[indexPath.row].id
//        if let vc = vc {
//            self.present(vc , animated: true, completion: nil)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 50
    }
    
}

extension MinimizedPlayerVC {
    
    fileprivate func setNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.white.cgColor
        context.nextFocusedView?.layer.shadowOpacity = 0.6
        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
        context.nextFocusedView?.layer.shadowRadius = 3
        context.nextFocusedView?.layer.cornerRadius = 10
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
        
        let nextFocusedView = String(describing: context.nextFocusedView)
        let previouslyFocusedView = String(describing: context.previouslyFocusedView)
        guard context.nextFocusedView != nil else {
            return
        }
        
        //setNextFocusUI(context)
        //setPrevioulyFocusedUI(context)
        
        //removeChildIfNead()
    }
}
