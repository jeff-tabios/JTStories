//
//  NetworkingTests.swift
//  JTStoriesUITests
//
//  Created by Jeff Tabios on 27/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTStories

class NetworkingTests: XCTestCase {

    let api = API()
    
    func test_getItems(){
        
        let expectation = self.expectation(description: "ConnectTest")
        
        var stories:Stories?
        
        api.request(endPoint: StoryAPI.getStories(page:1,q:"")) {(result:Result<Stories,APIServiceError>) in
            switch result{
            case .success(let response):
                expectation.fulfill()
                stories = response
            case .failure:
                break
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertEqual(stories?.response.docs.count, 10)
    }

}
