//
//  LawPavillionAppTests.swift
//  LawPavillionAppTests
//
//  Created by Apple on 5/12/22.
//

import XCTest
@testable import LawPavillionApp

class LawPavillionAppAsyncTests: XCTestCase {

    func testNetworkCall() {
        
        let exp = expectation(description: "Got github name lists")
        
        let queryString = "dev"
        Network.shared.makeCall(page: 1, queryString: "dev", completion: {response in
            
            XCTAssertNotNil(response.object)
            XCTAssertTrue(response.successful)
            exp.fulfill()
        })
        wait(for: [exp], timeout: 5.0)
    }
    
    
}
