//
//  HomeViewController.swift
//  LawPavillionApp
//
//  Created by Apple on 5/12/22.
//

import Foundation
import UIKit
import SDWebImage


class HomeviewController : UIViewController, UITextFieldDelegate {
    
    let detailsView = UIView()
    var items : [User] = []
    var currentPage = 1
    var homeUI: HomeUI?
    var viewModel : HomeViewModel?
    var currentQuery = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        viewModel = HomeViewModel()
        showResults()
        
        let reach = Reachability()
        if !reach.isConnectedToNetwork() {
            
            self.view.showtoast(message2: "No internet connection")
        }
        
    }
    
    func setupViews() {
        
        items.removeAll()
        homeUI = HomeUI(vc: self)
        homeUI!.setup()
        homeUI!.searchBtn.addTarget(self, action: #selector(showRes), for: .touchUpInside)
    }
    
    @objc func showRes() {
        
        loading()
        
        if homeUI!.input.text! == "" {
            
            self.view.showtoast(message2: "input is empty")
        }else {
            
            currentPage = 1
            items.removeAll()
            
            viewModel?.getData(page: currentPage, queryString: homeUI!.input.text)
            currentQuery = homeUI!.input.text!
        }
        
    }
    
    func loading() {
        
        if homeUI!.loadView.alpha == 0 {
            homeUI!.loadView.alpha = 1
        }else {
            homeUI!.loadView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            self.view.addSubview(homeUI!.loadView)
            homeUI?.loadView.constraint(equalToTop: self.view.topAnchor, equalToBottom: self.view.bottomAnchor, equalToLeft: self.view.leadingAnchor, equalToRight: self.view.trailingAnchor)
            
            homeUI!.loadView.addSubview(homeUI!.ind)
            homeUI!.ind.centre(centerX: homeUI!.loadView.centerXAnchor, centreY: homeUI!.loadView.centerYAnchor)
            homeUI!.ind.startAnimating()
        }
        
    }
    
    
    func showResults() {
        
        viewModel?.responseObserver.bind(completion: {[weak self] response in
            
            DispatchQueue.main.async {
                if self?.homeUI!.ind2.superview != nil {
                    self?.homeUI!.hideBottomIndicator()
                }
            }
            
            guard let response = response else {return}
            
            if response.successful {
               
                if let res = response.object as? [User] {
                    
                    let it = res.map({$0})
                    self?.items.append(contentsOf: it)
                    
                    DispatchQueue.main.async {
                        
                        /*for v in self!.homeUI!.loadView.subviews {
                            v.removeFromSuperview()
                        }
                        self?.homeUI!.loadView.removeFromSuperview()*/
                        
                        self?.homeUI!.loadView.alpha = 0
                        
                        self?.homeUI!.noItems.alpha = 0
                        self?.homeUI!.tableView.reloadData()
                        self?.currentPage += 1
                    }
                }
            }else {
                
                self?.view.showtoast(message2: response.message ?? "Something went wrong")
            }
               
        })
        
        /*viewModel?.downloadObserver.bind(completion: { [weak self] data in
            
            self?.homeUI.
        })*/
        
    }    

}

extension HomeviewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.id) as! ResultsTableViewCell
        cell.selectionStyle = .none
        
        if items.count > 0 {
            
            let user = items[indexPath.row]
            
            cell.notName.text = user.login
            cell.avatar_url.text = "Image url: " + (user.avatar_url ?? "")
            cell.typeUrl.text = "Type: " + user.type
            if let url = user.avatar_url {
                cell.image_view.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "img_avatar"))
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        homeUI!.showDetails(dict: items[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == items.count {
            
            let pages = UserDefaults.standard.object(forKey: "total_pages")as! Int
            if pages > (currentPage - 1) {
                viewModel?.getData(page: currentPage, queryString: currentQuery)
                homeUI!.showBottomIndicator()
            }
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
}
