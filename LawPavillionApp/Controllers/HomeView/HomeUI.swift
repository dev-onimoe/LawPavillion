//
//  HomeUI.swift
//  LawPavillionApp
//
//  Created by Mas'ud on 11/6/22.
//

import Foundation
import UIKit

class HomeUI {
    
    let vc : HomeviewController
    
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
    let ind = UIActivityIndicatorView()
    let ind2 = UIActivityIndicatorView()
    let loadView = UIView()
    
    init(vc: HomeviewController) {
        self.vc = vc
    }
    
    func setup() {
        
        self.vc.view.backgroundColor = UIColor.white
        self.vc.view.addSubview(backView)
        backView.constraint(equalToTop: vc.view.topAnchor, equalToBottom: vc.view.bottomAnchor, equalToLeft: vc.view.leadingAnchor, equalToRight: vc.view.trailingAnchor)
        backView.backgroundColor = UIColor.white
        
        
        input.constraint(height: 40)
        input.borderStyle = .none
        input.placeholder = "Search"
        input.font = Constants.lightFont(size: 12)
        input.delegate = vc
    
        input.textColor = .darkGray
        input.isUserInteractionEnabled = true
        
        searchBtn.constraint(width: 40)
        searchBtn.setImage(UIImage(named: "magnifyingglass"), for: UIControl.State.normal)
        //searchBtn.addTarget(self, action: #selector(showRes), for: .touchUpInside)
        
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
        resultLabel.textColor = Constants.navyBlue
        resultLabel.font = Constants.boldFont(size: 50)
        
        resultView.frame = CGRect(x: 16.0, y: 200.0, width: vc.view.frame.width - 32.0, height: vc.view.frame.height - (200.0 + 32.0))
        backView.addSubview(resultView)
        //resultView.constraint(equalToTop: resultLabel.bottomAnchor, equalToBottom: vc.view.bottomAnchor, equalToLeft: backView.leadingAnchor, equalToRight: backView.trailingAnchor, paddingTop: 16, paddingBottom: 32, paddingLeft: 16, paddingRight: 16)
        resultView.layer.cornerRadius = 12
        resultView.layer.borderWidth = 2
        resultView.layer.borderColor = Constants.navyBlue.cgColor
        print(vc.view.frame)
        //resultView.layoutIfNeeded()
        print(resultView.frame)
        
        tableView.frame = CGRect(x: 8, y: 8, width: resultView.frame.width - 16.0, height: resultView.frame.height - 66.0)
        resultView.addSubview(tableView)
        //tableView.constraint(equalToTop: resultView.topAnchor, equalToBottom: resultView.bottomAnchor, equalToLeft: resultView.leadingAnchor, equalToRight: resultView.trailingAnchor, paddingTop: 8, paddingBottom: 8, paddingLeft: 8, paddingRight: 8)
        tableView.tableFooterView = UIView()
        //tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = true
        tableView.isUserInteractionEnabled = true
        tableView.allowsSelection = true
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.id)
        tableView.separatorStyle = .none
        tableView.delegate = vc
        tableView.dataSource = vc
        
        resultView.addSubview(noItems)
        noItems.centre(centerX: resultView.centerXAnchor, centreY: resultView.centerYAnchor)
        noItems.text = "No items to display yet"
        noItems.textColor = Constants.navyBlue
        noItems.font = Constants.boldFont(size: 15)
        noItems.alpha = 1
        
        
    }
    
    @objc func removeKeyboard() {
        
        input.endEditing(true)
        
    }
    
    func showDetails(dict: User) {
        
        detailsView.frame = CGRect(x: 0, y: vc.view.bounds.height, width: vc.view.bounds.width, height: vc.view.bounds.height-30)
        detailsView.backgroundColor = .white
        vc.view.addSubview(detailsView)
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
        login.text = dict.login
        login.numberOfLines = 0
        login.textColor = Constants.navyBlue
        login.font = Constants.boldFont(size: 15)
        detailsView.addSubview(login)
        login.constraint(equalToTop: close.bottomAnchor, paddingTop: 16)
        login.centre(centerX: detailsView.centerXAnchor)
        
        let id = UILabel()
        id.text = "Id: " + String(dict.id)
        id.numberOfLines = 0
        id.textColor = .darkGray
        id.font = Constants.regularFont(size: 9)
        
        let nodeId = UILabel()
        nodeId.text = "Node_Id: " + dict.node_id
        nodeId.numberOfLines = 0
        nodeId.textColor = .darkGray
        nodeId.font = Constants.regularFont(size: 9)
        
        let avatar_url = UILabel()
        avatar_url.text = "Avatar_url: " + (dict.avatar_url ?? "")
        avatar_url.numberOfLines = 0
        avatar_url.textColor = .darkGray
        avatar_url.font = Constants.regularFont(size: 9)
        
        let gravatar_id = UILabel()
        gravatar_id.text = "Gravatar_id: " + (dict.gravatar_id ?? "")
        gravatar_id.numberOfLines = 0
        gravatar_id.textColor = .darkGray
        gravatar_id.font = Constants.regularFont(size: 9)
        
        let url = UILabel()
        url.text = "Url: " + dict.url
        url.numberOfLines = 0
        url.textColor = .darkGray
        url.font = Constants.regularFont(size: 9)
        
        let html_url = UILabel()
        html_url.text = "Html_url: " + dict.html_url
        html_url.numberOfLines = 0
        html_url.textColor = .darkGray
        html_url.font = Constants.regularFont(size: 9)
        
        let followers_url = UILabel()
        followers_url.text = "Followers_url: " + dict.followers_url
        followers_url.numberOfLines = 0
        followers_url.textColor = .darkGray
        followers_url.font = Constants.regularFont(size: 9)
        
        let following_url = UILabel()
        following_url.text = "Following_url: " + dict.following_url
        following_url.numberOfLines = 0
        following_url.textColor = .darkGray
        following_url.font = Constants.regularFont(size: 9)
        
        let gists_url = UILabel()
        gists_url.text = "Gists_url: " + dict.gists_url
        gists_url.numberOfLines = 0
        gists_url.textColor = .darkGray
        gists_url.font = Constants.regularFont(size: 9)
        
        let starred_url = UILabel()
        starred_url.text = "Starred_url: " + dict.starred_url
        starred_url.numberOfLines = 0
        starred_url.textColor = .darkGray
        starred_url.font = Constants.regularFont(size: 9)
        
        let subscriptions_url = UILabel()
        subscriptions_url.text = "Subscriptions_url: " + dict.subscriptions_url
        subscriptions_url.numberOfLines = 0
        subscriptions_url.textColor = .darkGray
        subscriptions_url.font = Constants.regularFont(size: 9)
        
        let organizations_url = UILabel()
        organizations_url.text = "Organizations_url: " + dict.organizations_url
        organizations_url.numberOfLines = 0
        organizations_url.textColor = .darkGray
        organizations_url.font = Constants.regularFont(size: 9)
        
        let repos_url = UILabel()
        repos_url.text = "Repos_url: " + dict.repos_url
        repos_url.numberOfLines = 0
        repos_url.textColor = .darkGray
        repos_url.font = Constants.regularFont(size: 9)
        
        let events_url = UILabel()
        events_url.text = "Events_url: " + dict.events_url
        events_url.numberOfLines = 0
        events_url.textColor = .darkGray
        events_url.font = Constants.regularFont(size: 9)
        
        let received_events_url = UILabel()
        received_events_url.text = "Received_events: " + dict.received_events_url
        received_events_url.numberOfLines = 0
        received_events_url.textColor = .darkGray
        received_events_url.font = Constants.regularFont(size: 9)
        
        let type = UILabel()
        type.text = "Type: " + dict.type
        type.numberOfLines = 0
        type.textColor = .darkGray
        type.font = Constants.regularFont(size: 9)
        
        let site_admin = UILabel()
        site_admin.text = "Site_admin: " + String(dict.site_admin)
        site_admin.numberOfLines = 0
        site_admin.textColor = .darkGray
        site_admin.font = Constants.regularFont(size: 9)
        
        let score = UILabel()
        score.numberOfLines = 0
        score.text = "Score: " + String(dict.score)
        score.textColor = .darkGray
        score.font = Constants.regularFont(size: 9)
        
        let stack = UIStackView(arrangedSubviews: [id, nodeId, avatar_url, gravatar_id, url, html_url, followers_url, following_url, gists_url, starred_url, subscriptions_url, organizations_url, repos_url, events_url, received_events_url, type, site_admin, score])
        detailsView.addSubview(stack)
        stack.constraint(equalToTop: login.bottomAnchor, equalToLeft: detailsView.leadingAnchor, equalToRight: detailsView.trailingAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        stack.spacing = 8
        stack.axis = .vertical
        stack.distribution = .fillEqually
    }
    
    @objc func closeDetails() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.detailsView.frame.origin.y = self.vc.view.bounds.height
        }, completion: {_ in
            
            for views in self.detailsView.subviews {
                
                views.removeFromSuperview()
            }
            self.detailsView.removeFromSuperview()
        })
    }
    
    func showBottomIndicator() {
        
        resultView.centreHorizontally(view: ind2, y: tableView.frame.height + 8.0, height: 30, width: 30)
        ind2.startAnimating()
        
    }
    
    func hideBottomIndicator() {
        
        ind2.removeFromSuperview()
    }
}
