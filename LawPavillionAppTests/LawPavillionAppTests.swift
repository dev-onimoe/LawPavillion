//
//  LawPavillionAppTests.swift
//  LawPavillionAppTests
//
//  Created by Apple on 5/12/22.
//

import XCTest
@testable import LawPavillionApp

class LawPavillionAppAsyncTests: XCTestCase {

    func testGettingNamesSuccessfully() {
        
        let exp = expectation(description: "Got github name lists")
        
        let queryString = "dev"
        guard let url = URL(string: Constants.url + queryString)else {return}
        let session = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            
            XCTAssertNil(error)
            XCTAssertNotNil(data)
            exp.fulfill()
            
        }).resume()
        wait(for: [exp], timeout: 5.0)
    }
    
    
}
