//
//  StoriesViewModelTests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 28/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTStories

class StoriesViewModelTests: XCTestCase {

    var sut = StoriesViewModel(api: MockAPI())
    
    func test_startAndget1Page() {
        sut.reload()
        XCTAssertEqual(sut.storyViewModels.count, 10)
    }
    
    func test_get2Pages() {
        sut.reload()
        XCTAssertEqual(sut.storyViewModels.count, 10)
        
        sut.getNextPage()
        XCTAssertEqual(sut.storyViewModels.count, 20)
    }
    
    func test_get2PagesThenRefresh() {
        sut.reload()
        XCTAssertEqual(sut.storyViewModels.count, 10)
        
        sut.getNextPage()
        XCTAssertEqual(sut.storyViewModels.count, 20)
        
        sut.reload()
        XCTAssertEqual(sut.storyViewModels.count, 10)
    }

}
