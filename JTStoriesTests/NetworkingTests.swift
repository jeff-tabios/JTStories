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

    let liveApi =  API()
    let mockApi = MockAPI()
    
    func test_getItems(){
        
        let expectation = self.expectation(description: "ConnectTest")
        
        var stories:Stories?
        
        mockApi.request(endPoint: StoryAPI.getStories(page:1,q:"")) {(result:Result<Stories,APIServiceError>) in
            switch result{
            case .success(let response):
                expectation.fulfill()
                stories = response
            case .failure:
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(stories?.response.docs.count, 10)
    }

    func test_decode(){
        let expectation1 = self.expectation(description: "GetTest")
        
        var stories:Stories?
        
        mockApi.request(endPoint: StoryAPI.getStories(page:1,q:"")) {(result:Result<Stories,APIServiceError>) in
            switch result{
            case .success:
                expectation1.fulfill()
            case .failure:
                XCTFail()
            }
            
        }
        
        let expectation2 = self.expectation(description: "DecodeTest")
        liveApi.data = mockApi.data
        
        liveApi.decode { (result:Result<Stories,APIServiceError>) in
            switch result{
            case .success(let response):
                stories = response
                expectation2.fulfill()
            case .failure:
                XCTFail()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertEqual(stories?.response.docs[0].headline.main, "Singapore Seizes Ivory From Nearly 300 Elephants in Record Haul")
        
    }
}
