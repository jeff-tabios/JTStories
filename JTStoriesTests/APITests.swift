//
//  APITests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 01/08/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTStories

class APITests: XCTestCase {
    
    let sut =  API()
    let mockApi = MockAPI()

    func test_getItemsWithPage1_returns10items(){
        
        let expectation = self.expectation(description: "GetPage1Test")
        
        var stories:Stories?
        
        sut.request(endPoint: StoryAPI.getStories(page:1,q:"")) {(result:Result<Stories,APIServiceError>) in
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
    
    func test_getNoItems_withWrongPage(){
        
        let expectation = self.expectation(description: "GetWrongPageTest")
        
        var stories:Stories?
        
        sut.request(endPoint: StoryAPI.getStories(page:-1,q:"")) {(result:Result<Stories,APIServiceError>) in
            switch result{
            case .success(let response):
                expectation.fulfill()
                stories = response
            case .failure:
                expectation.fulfill()
                break
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(stories?.response.docs.count, nil)
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
        sut.data = mockApi.data
        
        sut.decode { (result:Result<Stories,APIServiceError>) in
            switch result{
            case .success(let response):
                stories = response
                expectation2.fulfill()
            case .failure:
                XCTFail()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(stories?.response.docs[0].headline.main,
                       "Singapore Seizes Ivory From Nearly 300 Elephants in Record Haul")
        
    }
    
    func test_decodingWithMismatchModel_willFail(){
        let expectation1 = self.expectation(description: "GetTest")
        
        mockApi.request(endPoint: StoryAPI.getStories(page:1,q:"")) {(result:Result<Stories,APIServiceError>) in
            switch result{
            case .success:
                expectation1.fulfill()
            case .failure:
                XCTFail()
            }
            
        }
        
        let expectation2 = self.expectation(description: "DecodeTest")
        sut.data = mockApi.data
        var error: APIServiceError = .none
        sut.decode {(result:Result<Story,APIServiceError>) in
            switch result{
            case .success:
                XCTFail()
            case .failure(let err):
                error = err
                expectation2.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(error, APIServiceError.decodeError)
    }
    
    func test_requestNildata_willFail(){
        let expectation = self.expectation(description: "DecodeTest")
        var isFail = false
        sut.data = nil
        sut.decode { (result:Result<Stories,APIServiceError>) in
            switch result{
            case .success:
                XCTFail()
            case .failure:
                isFail = true
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(isFail)
    }
    
    func test_decodeWithWrongData_willFail(){
        let expectation = self.expectation(description: "DecodeTest")
        var isFail = false
        sut.data = Data()
        sut.decode { (result:Result<Stories,APIServiceError>) in
            switch result{
            case .success:
                XCTFail()
            case .failure:
                isFail = true
                expectation.fulfill()
            }
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertTrue(isFail)
    }
    
    func test_mockRequestWithNonExistingFile_willFail(){
        let expectation1 = self.expectation(description: "GetTest")
        mockApi.jsonFile = "somefilename"
        var error:APIServiceError = .none
        mockApi.request(endPoint: StoryAPI.getStories(page:1,q:"")) {(result:Result<Stories,APIServiceError>) in
            switch result{
            case .success:
                XCTFail()
            case .failure(let err):
                error = err
                expectation1.fulfill()
            }
            
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(error, APIServiceError.fileNotFound)
    }
    
}
