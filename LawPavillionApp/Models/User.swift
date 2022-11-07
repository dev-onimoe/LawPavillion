//
//  User.swift
//  LawPavillionApp
//
//  Created by Mas'ud on 11/6/22.
//

import Foundation

struct User {
    
    let id: Int
    let site_admin: Bool
    var score: Double
    var login: String
    var node_id: String
    var avatar_url: String?
    var gravatar_id: String?
    var url: String
    var html_url: String
    var followers_url: String
    var following_url: String
    var gists_url: String
    var starred_url: String
    var subscriptions_url: String
    var organizations_url: String
    var repos_url: String
    var events_url: String
    var received_events_url: String
    var type: String
    
    init(dict: [String: Any]) {
        id = dict["id"] as! Int
        site_admin = dict["site_admin"] as! Bool
        score = dict["score"] as! Double
        login = dict["login"] as! String
        node_id = dict["node_id"] as! String
        avatar_url = dict["avatar_url"] as! String
        gravatar_id = dict["gravatar_id"] as! String
        html_url = dict["html_url"] as! String
        followers_url = dict["followers_url"] as! String
        following_url = dict["following_url"] as! String
        gists_url = dict["gists_url"] as! String
        starred_url = dict["starred_url"] as! String
        subscriptions_url = dict["subscriptions_url"] as! String
        organizations_url = dict["organizations_url"] as! String
        repos_url = dict["repos_url"] as! String
        url = dict["url"] as! String
        events_url = dict["events_url"] as! String
        received_events_url = dict["received_events_url"] as! String
        type = dict["type"] as! String
    }
}
