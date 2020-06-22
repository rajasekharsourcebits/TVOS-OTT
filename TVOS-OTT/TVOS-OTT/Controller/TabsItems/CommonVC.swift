//
//  CommonVC.swift
//  TVOS-OTT
//
//  Created by Souvik on 25/05/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class CommonVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = CommonVCViewModel(provider: ServiceProvider<UserService>())
    var delegate: CommonVCModelDelegate?
    var data: [ListItems]?
    var tvData: [TVShowsItem]?
    
    var tabSelected: String = ""
    var sectionTitle: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.commonVCModelDelegate = self
        if tabSelected == "TVShows" {
            viewModel.callApi(view: self.view, serviceType: .top250tvShow)
        } else {
            viewModel.callApi(view: self.view, serviceType: .top250movies)
        }
    }
    
    func allocateSectionCount(_ title: String)  -> [String] {
        switch tabSelected {
        case "Home":
            return homeTitleArray
        case "TVShows":
            return tvShowsTitleArray
        case "Movies":
            return moviesTitleArray
        default:
            return homeTitleArray
        }
    }
}

extension CommonVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell {
            if tabSelected == "TVShows" {
                if  indexPath.section == 0 {
                    cell.tvModelData = tvData
                } else if  indexPath.section == 1 {
                    cell.tvModelData = tvData?.shuffled()
                } else if  indexPath.section == 2 {
                    cell.tvModelData = tvData?.shuffled()
                } else if  indexPath.section == 3 {
                    cell.tvModelData = tvData?.shuffled()
                } else if  indexPath.section == 4 {
                    cell.tvModelData = tvData?.shuffled()
                } else if  indexPath.section == 5 {
                    cell.tvModelData = tvData?.shuffled()
                } else  {
                    cell.model = data
                }
            } else {
                
                if  indexPath.section == 0 {
                    cell.model = data
                } else if  indexPath.section == 1 {
                    cell.model = data?.shuffled()
                } else if  indexPath.section == 2 {
                    cell.model = data?.shuffled()
                } else if  indexPath.section == 3 {
                    cell.model = data?.shuffled()
                } else if  indexPath.section == 4 {
                    cell.model = data?.shuffled()
                } else if  indexPath.section == 5 {
                    cell.model = data?.shuffled()
                } else  {
                    cell.model = data
                }
                
            }
            
            cell.tabSelected = tabSelected
            cell.myVC = self
            cell.collectionView.reloadData()
            return cell
        } else {
            return ItemTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 450
        
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 10, width: 1000, height: 50)
        myLabel.font = UIFont(name: "HelveticaNeue - Bold", size: 35)
        myLabel.text = sectionTitle[section]
        myLabel.textColor = UIColor.white
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
}

extension CommonVC: CommonVCModelDelegate {
    func updateUI() {
        sectionTitle = allocateSectionCount(tabSelected)
        if tabSelected == "TVShows" {
            tvData = viewModel.tvShowsData?.items
        } else {
            data = viewModel.data?.items
        }
        tableView.reloadData()
    }
    
    
}
