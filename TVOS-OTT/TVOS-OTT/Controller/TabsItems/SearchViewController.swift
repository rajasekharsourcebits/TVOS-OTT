//
//  SearchViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
    let viewModel = SearchViewModel(provider: ServiceProvider<UserService>())
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchCollectionView.remembersLastFocusedIndexPath = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numbareOfItems() 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell {
            cell.layer.cornerRadius = 10.0
            cell.clipsToBounds = true
            viewModel.configerCell(cell: cell, withIndex: indexPath.row)
            return cell
        } else {
            return SearchCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }

    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: 0, section: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Constants.expression = textField.text ?? ""
        viewModel.callApi(view: self.view)
        viewModel.searchViewModelDelegate = self
        return true
    }
}

extension SearchViewController {
    
    fileprivate func setNextFocusUI(_ context: UIFocusUpdateContext) {
        context.nextFocusedView?.layer.shadowColor = UIColor.black.cgColor
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
        
        guard context.nextFocusedView != nil else {
            return
        }
        setNextFocusUI(context)
        setPrevioulyFocusedUI(context)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func updateUI() {
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
    }
    
}

