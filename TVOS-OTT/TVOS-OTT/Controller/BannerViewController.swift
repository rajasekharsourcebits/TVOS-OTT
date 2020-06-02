//
//  BannerViewController.swift
//  TVOS-OTT
//
//  Created by Kiran on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class BannerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var bannerCollectioView: UICollectionView!
    @IBOutlet weak var bannerPageControl: UIPageControl!
    
    var index:Int = 0
    var bannerTimer: Timer?
    var dataCount: Int = 10
    
    @IBAction func scrollToNext(_ sender: Any) {
        if index < bannerPageControl.numberOfPages - 1 {
            index = index + 1
            moveToFrame(i: index)
        }
    }
    
    @IBAction func scrollToPrevious(_ sender: Any) {
        if index != 0 {
            index = index - 1
            moveToFrame(i: index)
        }
    }
    
    func moveToFrame(i : Int) {
        bannerCollectioView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        bannerPageControl.currentPage = i
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerPageControl.numberOfPages = dataCount
        bannerPageControl.currentPage = 0
        bannerTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    @objc func runTimedCode() {
        if index < bannerPageControl.numberOfPages - 1 {
            index = index + 1
            moveToFrame(i: index)
        } else {
            index = 0
            moveToFrame(i: index)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionViewCell", for: indexPath) as! BannerCollectionViewCell
        return cell
    }
    
}
