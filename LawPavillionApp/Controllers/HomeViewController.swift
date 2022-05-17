//
//  HomeViewController.swift
//  LawPavillionApp
//
//  Created by Apple on 5/12/22.
//

import Foundation
import UIKit


class HomeviewController : UIViewController, UITextFieldDelegate {
    
    let backView = UIView()
    var loadingView = UIView()
    let detailsView = UIView()
    let input = UITextField()
    let searchBtn = UIButton()
    let resultView = UIView()
    let tableView = UITableView()
    let pageLabel = UILabel()
    let noItems = UILabel()
    let pageStack = UIStackView()
    var totalItems : [[String : Any]] = [[:]]
    var items : [[String : Any]] = [[:]]
    var itemParent : [String : Any] = [:]
    var fetchCount = 0
    var currentPage = 1, totalPage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        
        let reach = Reachability()
        
        if !reach.isConnectedToNetwork() {
            
            self.view.showtoast(message2: "No internet connection")
        }
        
    }
    
    func setupViews() {
        
        items.removeAll()
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        backView.constraint(equalToTop: self.view.topAnchor, equalToBottom: self.view.bottomAnchor, equalToLeft: self.view.leadingAnchor, equalToRight: self.view.trailingAnchor)
        backView.backgroundColor = UIColor.white
        //self.view = backView
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeKeyboard))
        //backView.addGestureRecognizer(tap)
        
        input.constraint(height: 40)
        input.borderStyle = .none
        input.placeholder = "Search"
        input.font = UIFont(name: "Poppins-Light", size: 2)
        input.delegate = self
    
        input.textColor = .darkGray
        input.isUserInteractionEnabled = true
        
        searchBtn.constraint(width: 40)
        searchBtn.setImage(UIImage(named: "magnifyingglass"), for: UIControl.State.normal)
        searchBtn.addTarget(self, action: #selector(showRes), for: .touchUpInside)
        
        let stackBack = UIView()
        backView.addSubview(stackBack)
        stackBack.backgroundColor = .white
        stackBack.constraint(equalToTop: backView.topAnchor, equalToLeft: backView.leadingAnchor, equalToRight: backView.trailingAnchor, paddingTop: 60, paddingLeft: 16, paddingRight: 16, height: 45)
        stackBack.isUserInteractionEnabled = true
        stackBack.layer.cornerRadius = 12
        stackBack.shadowBorder()
        
        let searchStack = UIStackView(arrangedSubviews: [input, searchBtn])
        stackBack.addSubview(searchStack)
        searchStack.constraint(equalToTop: stackBack.topAnchor, equalToLeft: stackBack.leadingAnchor, equalToRight: stackBack.trailingAnchor, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 8)
        //stackBack.layer.cornerRadius = 12
        //searchStack.shadowBorder()
        searchStack.isUserInteractionEnabled = true
        searchStack.spacing = 5
        searchStack.distribution = .fill
        
        let resultLabel = UILabel()
        backView.addSubview(resultLabel)
        resultLabel.constraint(equalToTop: searchStack.bottomAnchor, equalToLeft: backView.leadingAnchor, paddingTop: 16, paddingLeft: 16)
        resultLabel.text = "Results"
        resultLabel.textColor = UIColor(hex: "#2F466C")
        resultLabel.font = UIFont(name: "Poppins-Bold", size: 50)
        
        backView.addSubview(resultView)
        resultView.constraint(equalToTop: resultLabel.bottomAnchor, equalToLeft: backView.leadingAnchor, equalToRight: backView.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        resultView.layer.cornerRadius = 12
        resultView.layer.borderWidth = 2
        resultView.layer.borderColor = UIColor(hex: "#2F466C").cgColor
        
        resultView.addSubview(tableView)
        tableView.constraint(equalToTop: resultView.topAnchor, equalToBottom: resultView.bottomAnchor, equalToLeft: resultView.leadingAnchor, equalToRight: resultView.trailingAnchor, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 8)
        tableView.tableFooterView = UIView()
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.id)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        resultView.addSubview(noItems)
        noItems.centre(centerX: resultView.centerXAnchor, centreY: resultView.centerYAnchor)
        noItems.text = "No items to display yet"
        noItems.textColor = UIColor(hex: "#2F466C")
        noItems.font = UIFont(name: "Poppins-Bold", size: 15)
        noItems.alpha = 1
        
        let prevBtn = UIButton()
        prevBtn.setTitle("Previous", for: .normal)
        prevBtn.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
        prevBtn.titleLabel?.textColor = .white
        prevBtn.layer.cornerRadius = 12
        prevBtn.backgroundColor = Constants.navyBlue
        prevBtn.constraint(width: 80, height: 40)
        prevBtn.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        
        
        pageLabel.text = "Page 0/0"
        pageLabel.font = UIFont(name: "Poppins-Regular", size: 18)
        pageLabel.textAlignment = .center
        pageLabel.textColor = Constants.navyBlue
        pageLabel.layer.cornerRadius = 12
        
        let nextLabel = UIButton()
        nextLabel.setTitle("Next", for: .normal)
        nextLabel.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
        nextLabel.titleLabel?.textColor = .white
        nextLabel.layer.cornerRadius = 12
        nextLabel.backgroundColor = Constants.navyBlue
        nextLabel.constraint(width: 80, height: 40)
        nextLabel.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        
        pageStack.addArrangedSubview(prevBtn)
        pageStack.addArrangedSubview(pageLabel)
        pageStack.addArrangedSubview(nextLabel)
        
        backView.addSubview(pageStack)
        pageStack.constraint(equalToTop: resultView.bottomAnchor, equalToBottom: backView.bottomAnchor, equalToLeft: backView.leadingAnchor, equalToRight: backView.trailingAnchor, paddingTop: 8, paddingBottom: 28, paddingLeft: 16, paddingRight: 16)
        pageStack.alpha = 0
    }
    
    @objc func showRes() {
        
        if input.text! == "" {
            
            self.view.showtoast(message2: "input is empty")
        }else {
            
            showResults()
        }
        
        
    }
    
    @objc func prevPage() {
        
        prevpg()
    }
    
    @objc func nextPage() {
        
        nextpg()
    }
    
    func loading() {
        
        self.view.addSubview(loadingView)
        loadingView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        //loadingView.alpha = 0.5
        loadingView.constraint(equalToTop: self.view.topAnchor, equalToBottom: self.view.bottomAnchor, equalToLeft: self.view.leadingAnchor, equalToRight: self.view.trailingAnchor)
        
        let centreView = UIView()
        loadingView.addSubview(centreView)
        centreView.backgroundColor = .white
        centreView.constraint(width: 250, height: 80)
        centreView.centre(centerX: loadingView.centerXAnchor, centreY: loadingView.centerYAnchor)
        centreView.shadowBorder()
        
        
        let load = UILabel()
        load.text = "Loading..."
        load.font = UIFont(name: "Poppins-Bold", size: 12)
        load.textColor = UIColor(hex: "#2F466C")
        loadingView.addSubview(load)
        load.centre(centerX: loadingView.centerXAnchor, centreY: loadingView.centerYAnchor)
    }
    
    func nextpg() {
       
        if fetchCount != totalItems.count {
            
            items.removeAll()
            for i in 0..<10 {
                    
                items.append(totalItems[(fetchCount)+i])
            }
            fetchCount = fetchCount + 10
            tableView.reloadData()
            currentPage = currentPage + 1
            pageLabel.text = "\(currentPage) / \(totalPage)"
        }
    }
    
    func prevpg() {
       
        if fetchCount > 10 {
            
            items.removeAll()
            for i in 0..<10 {
                    
                items.append(totalItems[(fetchCount-20)+i])
            }
            fetchCount = fetchCount - 10
            tableView.reloadData()
            currentPage = currentPage - 1
            pageLabel.text = "\(currentPage) / \(totalPage)"
        }
    }
    
    func showResults() {
        
        loading()
        
        var queryString = ""
        
        if let queryString2 = input.text {
            
            queryString = Constants.url + queryString2
        }
        
        guard let url = URL(string: queryString)else {return}
        let session = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            if let err = error {
                
                DispatchQueue.main.async {
                    
                    for views in self.loadingView.subviews {
                        views.removeFromSuperview()
                    }
                    self.loadingView.removeFromSuperview()
                    self.view.showtoast(message2: err.localizedDescription)
                }
                
                
            }else {
                
                if let responseData = data {
                    
                    let jsonRes = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any]
                    
                    if let res = jsonRes {
                        
                        self.itemParent = res
                        guard let users = res["items"] as? [[String : Any]] else {return}
                        self.totalItems = users.sorted(by: { ($0["login"] as! String).lowercased() < ($1["login"] as! String).lowercased()})
                        //print(self.totalItems.count)
                        self.totalPage = self.totalItems.count/10
                        self.items.removeAll()
                        for i in 0..<10 {
                                
                            self.items.append(self.totalItems[i])
                        }
                        self.fetchCount = 10
                        self.currentPage = 1
                        
                        DispatchQueue.main.async {
                            for views in self.loadingView.subviews {
                                views.removeFromSuperview()
                            }
                            self.loadingView.removeFromSuperview()
                        
                            
                            self.noItems.alpha = 0
                            self.tableView.reloadData()
                            self.pageStack.alpha = 1
                            self.pageLabel.text = "\(self.currentPage) / \(self.totalPage)"
                        }
                    }
                   
                    
                }
                
            }
        }).resume()
    }
    
    @objc func removeKeyboard() {
        
        input.endEditing(true)
        
    }
    
    func showDetails(dict: [String : Any]) {
        
        detailsView.frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: self.view.bounds.height-30)
        detailsView.backgroundColor = .white
        self.view.addSubview(detailsView)
        UIView.animate(withDuration: 0.5, animations: {
            
            self.detailsView.frame.origin.y = 30
        })
        detailsView.shadowBorder()
        
        let close = UIImageView(image: UIImage(named: "multiply"))
        detailsView.addSubview(close)
        close.constraint(equalToTop: detailsView.topAnchor, equalToRight: detailsView.trailingAnchor, paddingTop: 8, paddingRight: 8, width: 60, height: 60)
        close.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeDetails))
        close.addGestureRecognizer(tap)
        
        let login = UILabel()
        if let txt = dict["login"] as? String {
            login.text = txt
        }
        login.numberOfLines = 0
        login.textColor = Constants.navyBlue
        login.font = UIFont(name: "Poppins-Bold", size: 15)
        detailsView.addSubview(login)
        login.constraint(equalToTop: close.bottomAnchor, paddingTop: 16)
        login.centre(centerX: detailsView.centerXAnchor)
        
        let id = UILabel()
        if let txt = dict["id"] as? String {
            id.text = "id: " + txt
        }
        id.numberOfLines = 0
        id.textColor = .darkGray
        id.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let nodeId = UILabel()
        if let txt = dict["node_id"] as? String {
            nodeId.text = "node_id: " + txt
        }
        nodeId.numberOfLines = 0
        nodeId.textColor = .darkGray
        nodeId.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let avatar_url = UILabel()
        if let txt = dict["avatar_url"] as? String {
            avatar_url.text = "avatar_url: " + txt
        }
        avatar_url.numberOfLines = 0
        avatar_url.textColor = .darkGray
        avatar_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let gravatar_id = UILabel()
        if let txt = dict["gravatar_id"] as? String {
            gravatar_id.text = "gravatar_id: " + txt
        }
        gravatar_id.numberOfLines = 0
        gravatar_id.textColor = .darkGray
        gravatar_id.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let url = UILabel()
        if let txt = dict["url"] as? String {
            url.text = "url: " + txt
        }
        url.numberOfLines = 0
        url.textColor = .darkGray
        url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let html_url = UILabel()
        if let txt = dict["html_url"] as? String {
            html_url.text = "html_url: " + txt
        }
        html_url.numberOfLines = 0
        html_url.textColor = .darkGray
        html_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let followers_url = UILabel()
        if let txt = dict["followers_url"] as? String {
            followers_url.text = "followers_url: " + txt
        }
        followers_url.numberOfLines = 0
        followers_url.textColor = .darkGray
        followers_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let following_url = UILabel()
        if let txt = dict["following_url"] as? String {
            following_url.text = "following_url: " + txt
        }
        following_url.numberOfLines = 0
        following_url.textColor = .darkGray
        following_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let gists_url = UILabel()
        if let txt = dict["gists_url"] as? String {
            gists_url.text = "gists_url: " + txt
        }
        gists_url.numberOfLines = 0
        gists_url.textColor = .darkGray
        gists_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let starred_url = UILabel()
        if let txt = dict["starred_url"] as? String {
            starred_url.text = "starred_url: " + txt
        }
        starred_url.numberOfLines = 0
        starred_url.textColor = .darkGray
        starred_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let subscriptions_url = UILabel()
        if let txt = dict["subscriptions_url"] as? String {
            subscriptions_url.text = "subscriptions_url: " + txt
        }
        subscriptions_url.numberOfLines = 0
        subscriptions_url.textColor = .darkGray
        subscriptions_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let organizations_url = UILabel()
        if let txt = dict["organizations_url"] as? String {
            organizations_url.text = "organizations_url: " + txt
        }
        organizations_url.numberOfLines = 0
        organizations_url.textColor = .darkGray
        organizations_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let repos_url = UILabel()
        if let txt = dict["repos_url"] as? String {
            repos_url.text = "repos_url: " + txt
        }
        repos_url.numberOfLines = 0
        repos_url.textColor = .darkGray
        repos_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let events_url = UILabel()
        if let txt = dict["events_url"] as? String {
            events_url.text = "events_url: " + txt
        }
        events_url.numberOfLines = 0
        events_url.textColor = .darkGray
        events_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let received_events_url = UILabel()
        if let txt = dict["received_events_url"] as? String {
            received_events_url.text = "received_events_url: " + txt
        }
        received_events_url.numberOfLines = 0
        received_events_url.textColor = .darkGray
        received_events_url.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let type = UILabel()
        if let txt = dict["type"] as? String {
            type.text = "type: " + txt
        }
        type.numberOfLines = 0
        type.textColor = .darkGray
        type.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let site_admin = UILabel()
        if let txt = dict["site_admin"] as? String {
            site_admin.text = "site_admin: " + txt
        }
        site_admin.numberOfLines = 0
        site_admin.textColor = .darkGray
        site_admin.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let score = UILabel()
        score.numberOfLines = 0
        if let txt = dict["score"] as? String {
            score.text = "score: " + txt
        }
        score.textColor = .darkGray
        score.font = UIFont(name: "Poppins-Regular", size: 9)
        
        let stack = UIStackView(arrangedSubviews: [id, nodeId, avatar_url, gravatar_id, url, html_url, followers_url, following_url, gists_url, starred_url, subscriptions_url, organizations_url, repos_url, events_url, received_events_url, type, site_admin, score])
        detailsView.addSubview(stack)
        stack.constraint(equalToTop: login.bottomAnchor, equalToLeft: detailsView.leadingAnchor, equalToRight: detailsView.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        stack.spacing = 8
        stack.axis = .vertical
        stack.distribution = .fillEqually
    }
    
    @objc func closeDetails() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.detailsView.frame.origin.y = self.view.bounds.height
        }, completion: {_ in
            
            for views in self.detailsView.subviews {
                
                views.removeFromSuperview()
            }
            self.detailsView.removeFromSuperview()
        })
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
            
            cell.notName.text = items[indexPath.row]["login"] as! String
            cell.avatar_url.text = "Image url: " + (items[indexPath.row]["avatar_url"] as! String)
            cell.typeUrl.text = "Type: " + (items[indexPath.row]["type"] as! String)
        }
        
        /*if indexPath.row == items.count - 1 {
            
            if fetchCount != totalItems.count {
                
                items.removeAll()
                for i in 0..<10 {
                        
                    items.append(totalItems[(fetchCount)+i])
                }
                fetchCount = fetchCount + 10
                tableView.reloadData()
                pageLabel.text = "\(currentPage + 1) / \(totalPage)"
            }
        }*/
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        showDetails(dict: items[indexPath.row])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return false
    }
}
