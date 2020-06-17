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
    var data1: [ListItems]?
    var data2: [ListItems]?
    var data3: [ListItems]?
    var data4: [ListItems]?
    var data5: [ListItems]?
    var data6: [ListItems]?
    var testVar: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.commonVCModelDelegate = self
        viewModel.callApi(view: self.view, serviceType: .top250movies)
    }
    
    func allocateSectionCount(_ title: String)  -> Int {
        switch testVar {
        case "Home":
            return 5
        case "TVShows":
            return 1
        case "Movies":
            return 1
        default:
            return 1
        }
    }
}

extension CommonVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return allocateSectionCount(testVar)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as? ItemTableViewCell {
            
            if  indexPath.section == 0 {
                cell.model = data1
            } else if  indexPath.section == 1 {
                cell.model = data2
            } else if  indexPath.section == 2 {
                cell.model = data3
            } else if  indexPath.section == 3 {
                cell.model = data4
            } else if  indexPath.section == 4 {
                cell.model = data5
            } else if  indexPath.section == 5 {
                cell.model = data6
            } else  {
                cell.model = data1
            }
            cell.myVC = self
            cell.collectionView.reloadData()
            return cell
        } else {
            return ItemTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 416
        
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 0, y: 10, width: 500, height: 50)
        myLabel.font = UIFont(name: "Helvetica", size: 35)
        switch testVar {
        case "Home":
            switch section {
            case 0:
                myLabel.text = "MOST POPULAR MOVIES"
            case 1:
                myLabel.text = "MOST POPULAR TVSHOWS"
            case 2:
                myLabel.text = "COMING SOON"
            case 3:
                myLabel.text = "HOLLYWOOD MOVIES"
            case 4:
                myLabel.text = "BOLLYWOOD MOVIES"
            case 5:
                myLabel.text = "BOX OFFICE"
            default:
                myLabel.text = ""
            }
        case "TVShows":
            myLabel.text = "MOST POPULAR TVSHOWS"
        case "Movies":
            myLabel.text = "MOST POPULAR MOVIES"
        default:
            myLabel.text = "MOST POPULAR MOVIES"
        }
        
        
        myLabel.textColor = UIColor.white
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        return headerView
    }
    
}

extension CommonVC {
    
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
        //removeChildIfNead()
    }
}

extension CommonVC: CommonVCModelDelegate {
    func updateUI() {
        data1 = viewModel.data?.items
        data2 = data1?.shuffled()
        data3 = data2?.shuffled()
        data4 = data3?.shuffled()
        data5 = data4?.shuffled()
        data6 = data5?.shuffled()
        tableView.reloadData()
    }
    
    
}
