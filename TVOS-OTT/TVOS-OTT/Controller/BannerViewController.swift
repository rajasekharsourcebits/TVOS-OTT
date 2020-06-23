//
//  BannerViewController.swift
//  TVOS-OTT
//
//  Created by Kiran on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    //UI elements
    @IBOutlet weak var bannerCollectioView: UICollectionView!
    @IBOutlet weak var bannerPageControl: UIPageControl!

    var index:Int = 0
    var bannerTimer: Timer?
    var dataCount: Int = 5
    // To scroll the collection cell to next index
    @IBAction func scrollToNext(_ sender: Any) {
        if index < bannerPageControl.numberOfPages - 1 {
            index = index + 1
            moveToFrame(i: index)
        }
    }
    // To scroll the collection cell to previous index
    @IBAction func scrollToPrevious(_ sender: Any) {
        if index != 0 {
            index = index - 1
            moveToFrame(i: index)
        }
    }
    // Call to scroll collectionview cell
    func moveToFrame(i : Int) {
        bannerCollectioView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        bannerPageControl.currentPage = i
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerPageControl.numberOfPages = dataCount
        bannerPageControl.currentPage = 0
//        bannerTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    //Timer code to scroll collectionview cell automatically
    @objc func runTimedCode() {
        if index < bannerPageControl.numberOfPages - 1 {
            index = index + 1
            moveToFrame(i: index)
        } else {
            index = 0
            moveToFrame(i: index)
        }
    }
    //Item count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataCount
    }
    //Allocate cell and assign the data
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        cell.bannerImage.image = UIImage(named: "\(bannerImageArray[indexPath.item])")
        cell.bannerImage.adjustsImageWhenAncestorFocused = true
        return cell
    }
    //Focus update method used to update page control count
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        bannerCollectioView.isScrollEnabled = true
        if let indexPath = context.nextFocusedIndexPath {
            bannerPageControl.currentPage = [(indexPath[1])][0]
        }
    }
    
}
