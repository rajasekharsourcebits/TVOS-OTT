//
//  FavouritesViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class FavouritesViewController: UIViewController {
    
    //Property
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var supersubView: UIView!
    @IBOutlet weak var muyCollectionView: UICollectionView!
    
    var focusGuide = UIFocusGuide()
    var preferredFocusView: UIView?
    
//    override var preferredFocusEnvironments: [UIFocusEnvironment] {
//        return [playBtn]
//    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//                guard let watchNow = view.watchNowButton,
//            let transparentView = bannerView.transparentView else { return }
        //muyCollectionView.remembersLastFocusedIndexPath = false

        focusGuide.preferredFocusEnvironments = [playBtn]

        view.addLayoutGuide(focusGuide)

        focusGuide.topAnchor.constraint(equalTo: supersubView.topAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: supersubView.bottomAnchor).isActive = true
        focusGuide.leadingAnchor.constraint(equalTo: supersubView.leadingAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: supersubView.widthAnchor).isActive = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavouritesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavouriteCollectionCell", for: indexPath) as? FavouriteCollectionCell {
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            cell.layer.masksToBounds = true
            return cell
        } else {
            return FavouriteCollectionCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 250)
    }
    
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: 0, section: 0)
    }
    
    
}

extension FavouritesViewController {
    
    fileprivate func setNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.lightGray.cgColor
        context.nextFocusedView?.layer.shadowOpacity = 1
        context.nextFocusedView?.layer.shadowOffset = CGSize.zero
        context.nextFocusedView?.layer.shadowRadius = 5
       
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
        
        if previouslyFocusedView.contains("UITabBarButton") {
            setPreferredFocus(view: playBtn)
        }

        
        setNextFocusUI(context)
        setPrevioulyFocusedUI(context)
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
