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
    
    //UI Property
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var supersubView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var removeItemBtn: UIButton!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var noDataLbl: UILabel!
    
    // dynamic property
    var numberOfItemsPerRow = 4
    var currentselectedIndex = 0
    
    // custom focusguide property allocation
    var focusGuide = UIFocusGuide()
    var preferredFocusView: UIView?
    
    // api data model array
    var favList = [FavouriteModel]()
    
    // Using this declear property we can able to set our inital default focus.
    //    override var preferredFocusEnvironments: [UIFocusEnvironment] {
    //        return [playBtn]
    //    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // calling custom focus function.
        setConstraintToFocus()
        
    }
    
    func setConstraintToFocus() {
        
        focusGuide.preferredFocusEnvironments = [playBtn]
        
        view.addLayoutGuide(focusGuide)
        
        //custom focus set constraint for travel.
        focusGuide.topAnchor.constraint(equalTo: supersubView.topAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: supersubView.bottomAnchor).isActive = true
        focusGuide.leadingAnchor.constraint(equalTo: supersubView.leadingAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: supersubView.widthAnchor).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        // Fetching data from userDefault.
        if let favList = UserDefaults.getFavouriteList() {
            
            self.favList = favList
            
            // Set inital banner, title, desc, poster image of first element.
            setInitalFocusData()
            //collectionView horizontal and vertical spacing func
            configureFlowLayoutSpacing()
            collectionView.reloadData()
        } else {
            
        }
    }
    
    // MARK:- Inital ui set and dataloading func.
    func setInitalFocusData() {
        if let favList = favList.first {
            collectionView.isHidden = false
            myView.isHidden = false
            noDataLbl.isHidden = true
            nameLbl.text = favList.name
            descLbl.text = favList.desc
            noDataLbl.isHidden = true
            imgView.isHidden = false
            if let image = favList.image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    posterImage.sd_setImage(with: imageUrl, completed: nil)
                    imgView.sd_setImage(with: imageUrl, completed: nil)
                }
            }
            
        } else {
            collectionView.isHidden = true
            myView.isHidden = true
            noDataLbl.isHidden = false
            imgView.isHidden = true
        }
    }
    
    func configureFlowLayoutSpacing() {
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let maxWidthOfOneItem = collectionView.frame.width / CGFloat(numberOfItemsPerRow)
            let inset = maxWidthOfOneItem * 0.1
            
            flowLayout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
            flowLayout.minimumLineSpacing = inset
            flowLayout.minimumInteritemSpacing = inset
        }
    }
    
    // MARK:- UIButton Action
    @IBAction func playBtn(_ sender: Any) {
        
        //presenting to player View controller.
        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "MinimizedPlayerVC") as? MinimizedPlayerVC
        if let vc = vc {
            vc.pushFrom = "full"
            self.present(vc , animated: true, completion: nil)
            
        }
    }
    
    //Remove Item form userdefaults.
    @IBAction func RemoveFormList(_ sender: Any) {
        
        favList.remove(at: currentselectedIndex)
        UserDefaults.storeFavouriteList(programs: favList)
        setInitalFocusData()
        collectionView.reloadData()
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
            // enable it for focus parallex effect for image view or for cell go to cell class
            //cell.imgView.adjustsImageWhenAncestorFocused = true
            return cell
        } else {
            return FavouriteCollectionCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        // use this to get previous and next focused item.
        //print("Previous Focused Path: \(context.previouslyFocusedIndexPath)")
        //print("Next Focused Path: \(context.nextFocusedIndexPath)")
        
        if let value = context.nextFocusedIndexPath {
            // let item = lis[value.first ?? 0].cards?[value.last ?? 0]
            print(value)
            let item = favList[value.last ?? 0]
            currentselectedIndex = value.last ?? 0
            nameLbl.text = item.name
            descLbl.text = item.desc
            if let image = item.image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    posterImage.sd_setImage(with: imageUrl, completed: nil)
                    imgView.sd_setImage(with: imageUrl, completed: nil)
                }
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            let totalSpaceWidth = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItemsPerRow - 1))
            let width = Int((collectionView.bounds.width - totalSpaceWidth) / CGFloat(numberOfItemsPerRow))
            
            return CGSize(width: width, height: 300)
        }
        
        fatalError("collectionViewLayout is not UICollectionViewFlowLayout")
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
    
    //    fileprivate func setNextFocusUI(_ context: UIFocusUpdateContext) {
    //        context.nextFocusedView?.layer.shadowColor = UIColor.white.cgColor
    //        context.nextFocusedView?.layer.shadowOpacity = 0.2
    //        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
    //        context.nextFocusedView?.layer.shadowRadius = 3
    //        context.nextFocusedView?.layer.cornerRadius = 10
    //        context.nextFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    //    }
    //
    //    fileprivate func setPrevioulyFocusedUI(_ context: UIFocusUpdateContext) {
    //        context.previouslyFocusedView?.layer.shadowColor = UIColor.clear.cgColor
    //        context.previouslyFocusedView?.layer.shadowOpacity = 0
    //        context.previouslyFocusedView?.layer.shadowOffset = CGSize.zero
    //        context.previouslyFocusedView?.layer.shadowRadius = 0
    //        context.previouslyFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
    //    }
    
    
    //}
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        // on focus change default func which call
        
        let nextFocusedView = String(describing: context.nextFocusedView)
        let previouslyFocusedView = String(describing: context.previouslyFocusedView)
        guard context.nextFocusedView != nil else {
            return
        }
        
        // From tab bar  to programatically move to playbtn
        if previouslyFocusedView.contains("UITabBarButton") {
            setPreferredFocus(view: playBtn)
        }
        
        
        // use to update ui for next and previous focused item.
        if nextFocusedView.contains("UIButton") {
            setButtonNextFocusUI(context)
        } else {
            //self.setNextFocusUI(context)
            setNextFocusUI(context)
        }
        
        if previouslyFocusedView.contains("UIButton") {
            setButtonPrevioulyFocusedUI(context)
        } else {
            setPrevioulyFocusedUI(context)
        }
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
