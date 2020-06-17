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
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var removeItemBtn: UIButton!
    
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
            cell.imgView.layer.cornerRadius = 10
            //cell.clipsToBounds = true
            //cell.layer.masksToBounds = true
            return cell
        } else {
            return FavouriteCollectionCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/4) - 20, height: 340)
    }
    
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: 0, section: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("hello")
        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        vc?.viewModel.detailID = "Hello"
        if let vc = vc {
            self.present(vc , animated: true, completion: nil)
        }
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
    
    fileprivate func setButtonNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.black.cgColor
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
