//
//  SearchViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 18/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate, UICollectionViewDelegateFlowLayout {
   
    //UI Property
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // Variables and Constants
    let viewModel = SearchViewModel(provider: ServiceProvider<UserService>())
    var data: [searchList]?
    var isDataLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initalSetup(
        Constants.expression = "Latesthollywoodmovies"
        viewModel.callApi(view: self.view)
        viewModel.searchViewModelDelegate = self
        searchCollectionView.remembersLastFocusedIndexPath = true
    }
     // Add number of item Count
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    // Allocate Cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell {
            cell.layer.cornerRadius = 10.0
            cell.clipsToBounds = true
            setImage(indexPath.row, cell)
            return cell
        } else {
            return SearchCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Use this code to navigate to details screen
        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
        vc?.viewModel.detailID = data?[indexPath.item].id
        if let vc = vc {
            self.present(vc , animated: true, completion: nil)
        }
    }
    
    // Fetch the image Url from the response
    func getPath(_ withIndex: Int) -> String{
        if let path = data?[withIndex].image {
            return path
        } else {
            return Constants.noImageUrl
        }
    }
    
    //Set image from the Response / Set default image
    func setImage(_ withIndex: Int, _ cell: SearchCollectionViewCell) {
        let path = getPath(withIndex)
        if path == "" {
            cell.banner.downloadImageFrom(url: Constants.noImageUrl, contentMode: .scaleToFill)
        } else {
            let imageUrl = URL.init(string: path)
            if let imageUrl = imageUrl {
                cell.banner.sd_setImage(with: imageUrl, completed: nil)
                cell.banner.adjustsImageWhenAncestorFocused = true
            }
        }
    }
    
    func configerCell(cell: SearchCollectionViewCell, withIndex: Int) {
        setImage(withIndex, cell)
    }
    //Define collection view cell size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 300)
    }
    // Set default Focus to first cell
    func indexPathForPreferredFocusedView(in collectionView: UICollectionView) -> IndexPath? {
        return IndexPath(item: 0, section: 0)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Constants.expression = textField.text ?? ""
        viewModel.callApi(view: self.view)
        return true
    }
}

extension SearchViewController {
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        guard context.nextFocusedView != nil else {
            return
        }
        
        // Common extention to update previous and next focus ui.
        setNextFocusUI(context)
        setPrevioulyFocusedUI(context)
    }
}

extension SearchViewController: SearchViewModelDelegate {
    // Delegate to update the UI with the response
    func updateUI() {
        data = viewModel.searchModel?.results
        if isDataLoaded {
            if data?.count == 0 {
                titleLabel.text = "We couldn't find anything matching " + "  \(searchField.text ?? "")"
            } else {
                titleLabel.text = "\(data?.count ?? 0)" + " found for " + "  \(searchField.text ?? "")"
            }
        } else {
            isDataLoaded = true
        }
        
        DispatchQueue.main.async {
            self.searchCollectionView.reloadData()
        }
    }
    
}


