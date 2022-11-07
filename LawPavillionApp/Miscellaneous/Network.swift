//
//  Network.swift
//  LawPavillionApp
//
//  Created by Mas'ud on 11/6/22.
//

import Foundation

class Network {
    
    static let shared = Network()
    
    func makeCall(page: Int?, queryString: String?, completion: @escaping (Response) -> Void) {
        
        var query = ""
        
        if let queryString2 = queryString {
            
            query = Constants.url + queryString2 + "&page=\(String(page ?? 1))&per_page=10"
        }
        
        guard let url = URL(string: query) else {return}
        let session = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            if let err = error {
                
                completion(Response(successful: false, message: err.localizedDescription, object: nil))
            }else {
                
                if let responseData = data {
                    
                    let jsonRes = try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String : Any]
                    
                    if let res = jsonRes {
                        
                        guard let total_cost = res["total_count"] as? Int else {return}
                        UserDefaults.standard.set(Int(total_cost/10), forKey: "total_pages")
                        
                        guard let users = res["items"] as? [[String : Any]] else {return}
                        let totalItems = users.sorted(by: { ($0["login"] as! String).lowercased() < ($1["login"] as! String).lowercased()})
                        let usersArray = totalItems.map({User(dict: $0)})
                        completion(Response(successful: true, message: "successful", object: usersArray))
                        
                    }
                   
                    
                }
                
            }
        }).resume()
    }
    
}

struct Response {
    
    var successful : Bool
    var message: String?
    var object : Any?
}
