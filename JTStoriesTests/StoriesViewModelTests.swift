//
//  StoriesViewModelTests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 28/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest

class StoriesViewModelTests: XCTestCase {

    var sut = StoryListViewModel(api: MockAPI())
    
    func test_startAndget1Page() {
        sut.refresh()
        XCTAssertEqual(sut.storyViewModels.value.count, 20)
    }
    
    func test_get2Pages() {
        sut.refresh()
        XCTAssertEqual(sut.storyViewModels.value.count, 20)
        
        sut.getNextPage()
        XCTAssertEqual(sut.storyViewModels.value.count, 40)
    }

}
