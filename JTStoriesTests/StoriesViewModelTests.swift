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
        sut.refresh()
        XCTAssertEqual(sut.storyViewModels.count, 10)
    }
    
    func test_get2Pages() {
        sut.refresh()
        XCTAssertEqual(sut.storyViewModels.count, 10)
        
        sut.getNextPage()
        XCTAssertEqual(sut.storyViewModels.count, 20)
    }
    
    func test_get2PagesThenRefresh() {
        sut.refresh()
        XCTAssertEqual(sut.storyViewModels.count, 10)
        
        sut.getNextPage()
        XCTAssertEqual(sut.storyViewModels.count, 20)
        
        sut.refresh()
        XCTAssertEqual(sut.storyViewModels.count, 10)
    }

    func test_processStories(){
        let multimedia = Multimedia(url: "/test/url/image.jpg")
        let story = Story(snippet: "Test Snippet",
                          multimedia: [multimedia],
                          headline: Headline(main: "Test Headline"))
        
        let vms = sut.processStories(items: [story])
        
        XCTAssertEqual(vms[0].headline, story.headline.main)
        XCTAssertEqual(vms[0].snippet, story.snippet)
        XCTAssertEqual(vms[0].image, UIImage(named: AppConstants.imgUrl + story.multimedia[0].url))
        
    }
}
