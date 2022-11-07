//
//  HomeViewModel.swift
//  LawPavillionApp
//
//  Created by Mas'ud on 11/6/22.
//

import Foundation

class HomeViewModel {
    
    var responseObserver : Observable<Response?> = Observable(nil)
     
    func getData(page: Int?, queryString: String?) {
        
        Network.shared.makeCall(page: page, queryString: queryString, completion: {[weak self] response in
            
            if response.successful {
                
                self?.responseObserver.value = Response(successful: true, object: response.object)
            }else {
                self?.responseObserver.value = Response(successful: false, message: response.message, object: nil)
            }
        })
    }
}
