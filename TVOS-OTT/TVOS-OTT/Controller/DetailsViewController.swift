//
//  DetailsViewController.swift
//  TVOS-OTT
//
//  Created by Souvik on 10/06/20.
//  Copyright © 2020 Sourcebits. All rights reserved.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    //UI Property
    @IBOutlet weak var watchNowBtn: UIButton!
    @IBOutlet weak var favouriteBtn: UIButton!
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var tilteLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var yerLbl: UILabel!
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var bacGroundImgView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // Variables and Constants
    var viewModel = DetailViewModel(provider: ServiceProvider<UserService>())
    var focusGuide = UIFocusGuide()
    var preferredFocusView: UIView?
    var favList = [FavouriteModel]()
    
    let tvSectionIndex = ["Series", "Trailers", "Cast & Crew", "Related Shows"]
    let movieSectionIndex = ["Trailers", "Cast & Crew", "Related Movies"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //initalSetup()
        yerLbl.layer.borderWidth = 1.0
        yerLbl.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        yerLbl.layer.cornerRadius = 8
        viewModel.callApi(view: self.view)
        viewModel.delegate = self
        fetchFavList()
        focusConstraint()
        
    }
    
    // Get item from userDefaults
    func fetchFavList() {
        if let favList = UserDefaults.getFavouriteList() {
            self.favList = favList
        }
    }
    
    func checkFavouriteItem() {
        if let id = viewModel.detailModel?.id {
            let bool = favList.contains {$0.id == id}
            if bool {
                favouriteBtn.setTitle("Remove Favourite", for: .normal)
            } else {
                favouriteBtn.setTitle("Add Favourite", for: .normal)
            }
        }
    }
    
    @IBAction func WatchNow(_ sender: Any) {
        let vc = UIStoryboard.init(name: "SubScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "MinimizedPlayerVC") as? MinimizedPlayerVC
        if let vc = vc {
            vc.pushFrom = "full"
            self.present(vc , animated: true, completion: nil)
            
        }
    }
    
    // Add or Remove item to favourite.
    @IBAction func addToFavourite(_ sender: Any) {
        
        if let id = viewModel.detailModel?.id {
            let bool = favList.contains {$0.id == id}
            if bool {
                let indexOfA = favList.firstIndex{ $0.id == id}
                if let indexofA = indexOfA {
                    favList.remove(at: indexofA)
                    favouriteBtn.setTitle("Add Favourite", for: .normal)
                    UserDefaults.storeFavouriteList(programs: favList)
                }
                
            } else {
                if let model = viewModel.detailModel {
                    let newItem = FavouriteModel(id: model.id, name: model.fullTitle, image: model.image, desc: model.plot)
                    self.favList.append(newItem)
                    favouriteBtn.setTitle("Remove Favourite", for: .normal)
                    UserDefaults.storeFavouriteList(programs: self.favList)
                }
            }
        }
    }
    
    //Set default focus using custom focusGide.
    func focusConstraint() {
        focusGuide.preferredFocusEnvironments = [watchNowBtn]
        
        view.addLayoutGuide(focusGuide)
        
        focusGuide.topAnchor.constraint(equalTo: transparentView.topAnchor).isActive = true
        focusGuide.bottomAnchor.constraint(equalTo: transparentView.bottomAnchor).isActive = true
        focusGuide.leadingAnchor.constraint(equalTo: transparentView.leadingAnchor).isActive = true
        focusGuide.widthAnchor.constraint(equalTo: transparentView.widthAnchor).isActive = true
    }
    
}

extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // Add number of section Count.
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if let type = viewModel.detailModel?.type {
            if type == "Movie" {
                return 3
            } else  {
                return 4
            }
        }
        return 0
    }
    
    // Add number of Row Count.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Allocate Cell
        if let model = viewModel.detailModel {
            if model.type == "Movie" {
                if indexPath.section == 1 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "CastCrewTableViewCell", for: indexPath) as? CastCrewTableViewCell {
                        cell.referenceVC = self
                        cell.set(withData: indexPath.section, list: model.actorList)
                        return cell
                    } else {
                        return CastCrewTableViewCell()
                    }
                } else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTopTableViewCell", for: indexPath) as? DetailTopTableViewCell {
                        if indexPath.section == 0 {
                            let item = model.similars?.first
                            var items = [Similar]()
                            if let item = item {
                                items.append(item)
                                cell.set(withData: indexPath.section, list: items, myVC: self, type: model.type)
                            }
                            
                        } else {
                            cell.set(withData: indexPath.section, list: model.similars, myVC: self, type: model.type)
                        }
                        
                        
                        return cell
                    } else {
                        return DetailTopTableViewCell()
                    }
                }
                
            } else  {
                if indexPath.section == 2 {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "CastCrewTableViewCell", for: indexPath) as? CastCrewTableViewCell {
                        cell.referenceVC = self
                        cell.set(withData: indexPath.section, list: model.actorList)
                        return cell
                    } else {
                        return CastCrewTableViewCell()
                    }
                } else {
                    if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTopTableViewCell", for: indexPath) as?  DetailTopTableViewCell {
                        if indexPath.section == 1 {
                            let item = model.similars?.first
                            var items = [Similar]()
                            if let item = item {
                                items.append(item)
                                cell.set(withData: indexPath.section, list: items, myVC: self, type: model.type)
                            }
                            
                        } else {
                            cell.set(withData: indexPath.section, list: model.similars, myVC: self, type: model.type)
                        }
                        
                        
                        return cell
                    } else {
                        return DetailTopTableViewCell()
                    }
                }
                
            }
        }
        
        return DetailTopTableViewCell()
    }
    
    // Set UITableView Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let type = viewModel.detailModel?.type {
            if type == "Movie" {
                if indexPath.section == 1 {
                    return 340
                } else {
                    return 350
                }
            } else  {
                if indexPath.section == 2 {
                    return 340
                } else {
                    return 350
                }
            }
        }
        return 0
        
        
    }
    
    // Add UITableView Custom Header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 20, y: 10, width: 1000, height: 50)
        myLabel.font = UIFont(name: "HelveticaNeue - Bold", size: 35)
        if let type = viewModel.detailModel?.type {
            if type == "Movie" {
                myLabel.text = movieSectionIndex[section]
            } else {
                myLabel.text = tvSectionIndex[section]
            }
        }
        
        myLabel.textColor = UIColor.white
        let headerView = UIView()
        headerView.addSubview(myLabel)
        
        
        
        return headerView
    }
    
    // Add section Header Height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
    
    //** Disable Row focus to set focus on collectionView item cell.
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension DetailsViewController {
    
    // on focus change default func didUpdateFocus
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

// Delegate to refresh data onces get Data from api.
extension DetailsViewController: DetailModelDelegate {
    func updateUI() {
        
        if let model = viewModel.detailModel {
            tilteLbl.text = model.fullTitle ?? ""
            descLbl.text = model.plot
            timeLbl.text = model.runtimeStr
            yerLbl.text = model.imDbRating
            checkFavouriteItem()
            if let image = model.image {
                let imageUrl = URL.init(string: image)
                if let imageUrl = imageUrl {
                    posterImgView.sd_setImage(with: imageUrl, completed: nil)
                    bacGroundImgView.sd_setImage(with: imageUrl, completed: nil)
                    
                }
            }
            tableView.reloadData()
        }
    }
    
    
}
