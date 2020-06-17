//
//  FavouritesViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import SDWebImage

class FavouritesViewController: UIViewController {
    //Property
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var supersubView: UIView!
    @IBOutlet weak var muyCollectionView: UICollectionView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var removeItemBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    var currentselectedIndex = 0
    @IBOutlet weak var noDataLbl: UILabel!
    
    var focusGuide = UIFocusGuide()
    var preferredFocusView: UIView?
    
    var favList = [FavouriteModel]()
    
//    override var preferredFocusEnvironments: [UIFocusEnvironment] {
//        return [playBtn]
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        focusGuide.preferredFocusEnvironments = [playBtn]

        view.addLayoutGuide(focusGuide)

        focusGuide.topAnchor.constraint(equalTo: supersubView.topAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: supersubView.bottomAnchor).isActive = true
        focusGuide.leadingAnchor.constraint(equalTo: supersubView.leadingAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: supersubView.widthAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let favList = UserDefaults.getFavouriteList() {
            
            self.favList = favList
            setInitalFocusData()
            muyCollectionView.reloadData()
        } else {
            
        }
    }
    
    @IBAction func REviveFormList(_ sender: Any) {
        
        favList.remove(at: currentselectedIndex)
        UserDefaults.storeFavouriteList(programs: favList)
        setInitalFocusData()
        muyCollectionView.reloadData()
    }
    

    func setInitalFocusData() {
        if let favList = favList.first {
            muyCollectionView.isHidden = false
            myView.isHidden = false
            noDataLbl.isHidden = true
            nameLbl.text = favList.name
            descLbl.text = favList.desc
            noDataLbl.isHidden = true
            if let image = favList.image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    posterImage.sd_setImage(with: imageUrl, completed: nil)
                }
            }
            
        } else {
            muyCollectionView.isHidden = true
            myView.isHidden = true
            noDataLbl.isHidden = false
        }
    }

}

extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionCell", for: indexPath) as? FavouriteCollectionCell {
            cell.imgView.layer.cornerRadius = 10
            //cell.clipsToBounds = true
            //cell.layer.masksToBounds = true
            if let image = favList[indexPath.row].image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    cell.imgView.sd_setImage(with: imageUrl, completed: nil)
                }
            }
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
        
        if let value = context.nextFocusedIndexPath {
           // let item = lis[value.first ?? 0].cards?[value.last ?? 0]
            print(value)
            let item = favList[value.first ?? 0]
            currentselectedIndex = value.first ?? 0
            nameLbl.text = item.name
            descLbl.text = item.desc
            
            if let image = item.image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    posterImage.sd_setImage(with: imageUrl, completed: nil)
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/4) - 20, height: 300)
    }
    
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: 0, section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        vc?.viewModel.detailID = favList[indexPath.row].id
        if let vc = vc {
            self.present(vc , animated: true, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 50
    }
    
}

extension FavouritesViewController {
    
    fileprivate func setNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.white.cgColor
        context.nextFocusedView?.layer.shadowOpacity = 0.6
        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
        context.nextFocusedView?.layer.shadowRadius = 3
       
        context.nextFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }
    
    fileprivate func setPrevioulyFocusedUI(_ context: UIFocusUpdateContext) {
        context.previouslyFocusedView?.layer.shadowColor = UIColor.clear.cgColor
        context.previouslyFocusedView?.layer.shadowOpacity = 0
        context.previouslyFocusedView?.layer.shadowOffset = CGSize.zero
        context.previouslyFocusedView?.layer.shadowRadius = 0
        context.previouslyFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
    }
    
    fileprivate func setButtonNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.white.cgColor
        context.nextFocusedView?.layer.shadowOpacity = 1
        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
        context.nextFocusedView?.layer.shadowRadius = 5
        context.nextFocusedView?.backgroundColor = #colorLiteral(red: 0, green: 0.3620362878, blue: 0.6688420177, alpha: 1)
        //let value = context.previouslyFocusedView?.subviews.first
        
        if let button = context.nextFocusedView as? UIButton {
          button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        }
        //value?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        context.nextFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }
    
    fileprivate func setButtonPrevioulyFocusedUI(_ context: UIFocusUpdateContext) {
        context.previouslyFocusedView?.layer.shadowColor = UIColor.clear.cgColor
        context.previouslyFocusedView?.layer.shadowOpacity = 0
        context.previouslyFocusedView?.layer.shadowOffset = CGSize.zero
        context.previouslyFocusedView?.layer.shadowRadius = 0
        context.previouslyFocusedView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //let value = context.previouslyFocusedView?.subviews.first
        if let button = context.previouslyFocusedView as? UIButton {
          button.setTitleColor(#colorLiteral(red: 0.1824023128, green: 0.4893192053, blue: 0.9649513364, alpha: 1), for: .normal)
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        let nextFocusedView = String(describing: context.nextFocusedView)
        let previouslyFocusedView = String(describing: context.previouslyFocusedView)
        guard context.nextFocusedView != nil else {
            return
        }
        
        if previouslyFocusedView.contains("UITabBarButton") {
            setPreferredFocus(view: playBtn)
        }
        
        if nextFocusedView.contains("UIButton") {
            setButtonNextFocusUI(context)
        } else {
           setNextFocusUI(context)
        }
        
        if previouslyFocusedView.contains("UIButton") {
            setButtonPrevioulyFocusedUI(context)
        } else {
            setPrevioulyFocusedUI(context)
        }
        //removeChildIfNead()
    }
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        guard let focusView = preferredFocusView else { return [] }

        return [focusView]
    }

    // Set the preferred focus view by value
    func setPreferredFocus(view: UIView) {
        preferredFocusView = view

        setNeedsFocusUpdate()
        updateFocusIfNeeded()
    }
}
