//
//  CastCrewDetailViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 12/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import SDWebImage

class CastCrewDetailViewController: UIViewController {
    
    @IBOutlet weak var focusBtn: UIButton!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var viewModel = CastCrewViewModel(provider: ServiceProvider<UserService>())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.callApi(view: self.view)
        viewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
}

extension CastCrewDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTopTableViewCell", for: indexPath) as? DetailTopTableViewCell {
            
            cell.set(withData: indexPath.section, list: viewModel.model?.knownFors, myVC: self, type: nil)
            
            return cell
        } else {
            return DetailTopTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 426
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Related Movies/Shows"
//        switch section {
//        case 0:
//            return "Related Movies/Shows"
//        default:
//            return "Shows"
//        }
        //"Indian \(section)"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.clear //UIColor.lightGray.withAlphaComponent(0.3)
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.white
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension CastCrewDetailViewController {
    
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        let nextFocusedView = String(describing: context.nextFocusedView)
        let previouslyFocusedView = String(describing: context.previouslyFocusedView)
        
        guard context.nextFocusedView != nil else {
            return
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
    }
}

extension CastCrewDetailViewController: CastCrewDelegate {
    func updateUI() {
        
        if let model = viewModel.model {
            castName.text = model.name ?? ""
            descLbl.text = model.summary
            if let image = model.image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    profileImg.sd_setImage(with: imageUrl, completed: nil)
                    
                }
            }
            tableView.reloadData()
        }
    }
}



