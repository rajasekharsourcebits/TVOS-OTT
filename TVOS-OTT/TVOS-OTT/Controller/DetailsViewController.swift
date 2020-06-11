//
//  DetailsViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 10/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var watchNowBtn: UIButton!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var transparentView: UIView!
    
    var focusGuide = UIFocusGuide()
    var preferredFocusView: UIView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //initalSetup()
        focusConstraint()
        
    }
    
    func focusConstraint() {
        focusGuide.preferredFocusEnvironments = [watchNowBtn]

        view.addLayoutGuide(focusGuide)

        focusGuide.topAnchor.constraint(equalTo: transparentView.topAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor).isActive = true
        focusGuide.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: transparentView.widthAnchor).isActive = true
    }


    func initalSetup() {
       watchNowBtn.layer.shadowColor = UIColor.black.cgColor
       watchNowBtn.layer.shadowOpacity = 1
       watchNowBtn.layer.shadowOffset = CGSize.zero
       watchNowBtn.layer.shadowRadius = 5
       watchNowBtn.backgroundColor = #colorLiteral(red: 0, green: 0.3620362878, blue: 0.6688420177, alpha: 1)
       watchNowBtn.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
       watchNowBtn.transform = CGAffineTransform.identity.scaledBy(x: 1.1, y: 1.1)
    }

}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0, 1, 3:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTopTableViewCell", for: indexPath) as? DetailTopTableViewCell {
                
                cell.set(withData: indexPath.section)
                
                return cell
            } else {
                return DetailTopTableViewCell()
            }
            
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "CastCrewTableViewCell", for: indexPath) as? CastCrewTableViewCell {
                
                return cell
            } else {
                return CastCrewTableViewCell()
            }
        default:
            return ItemTableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
           return 326
        } else {
          return 426
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Season 1"
        case 1:
            return "Trailers"
        case 2:
            return "Cast & Crew"
        default:
            return "Related Show"
        }
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

extension DetailsViewController {
    
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
        //value?.setTitleColor(#colorLiteral(red: 0.1824023128, green: 0.4893192053, blue: 0.9649513364, alpha: 1), for: .normal)
        context.previouslyFocusedView?.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
    }
    
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        let nextFocusedView = String(describing: context.nextFocusedView)
        let previouslyFocusedView = String(describing: context.previouslyFocusedView)
        
        guard context.nextFocusedView != nil else {
            return
        }
        
        if previouslyFocusedView.contains("UITabBarButton") {
            setPreferredFocus(view: watchNowBtn)
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
