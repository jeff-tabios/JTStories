//
//  TermsViewModelTests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 01/08/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTStories

class TermsViewModelTests: XCTestCase {
    
    var sut:TermsViewModel!
    
    override func setUp() {
        super.setUp()
        sut = TermsViewModel(terms: [])
    }
    
    func test_startWithNoTerms(){
        XCTAssertEqual(sut.count, 0)
    }
    
    func test_save1Term_returns1Term(){
        sut.save(term: "test")
        XCTAssertEqual(sut.getTerm(0), "test")
    }
    
    func test_save3Terms_returns3counts(){
        sut.save(term: "test1")
        sut.save(term: "test2")
        sut.save(term: "test3")
        XCTAssertEqual(sut.count, 3)
    }
    
    func test_getTerms_returnsReversedArrayTerms(){
        sut.save(term: "test1")
        sut.save(term: "test2")
        sut.save(term: "test3")
        XCTAssertEqual(sut.getTerms(), ["test3","test2","test1"])
    }
    
    func test_maxTermCapacity_EqualsMaxItemsSetting(){
        sut.save(term: "test1")
        sut.save(term: "test2")
        sut.save(term: "test3")
        sut.save(term: "test4")
        sut.save(term: "test5")
        sut.save(term: "test6")
        sut.save(term: "test7")
        sut.save(term: "test8")
        sut.save(term: "test9")
        sut.save(term: "test10")
        sut.save(term: "test11")
        sut.save(term: "test12")
        XCTAssertEqual(sut.count, sut.maxItems)
    }

}
