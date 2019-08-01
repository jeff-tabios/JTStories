//
//  StoryViewModelTests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 01/08/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTStories

class StoryViewModelTests: XCTestCase {

    var sut:StoryViewModel!
    let multimedia = Multimedia(url: "images/2019/04/01/world/01singapore-1/merlin_152920632_816eb94d-089d-4fe5-be33-d05de16f88f9-articleLarge.jpg")
    let headline = Headline(main: "Test Headline")
    let snippet = "Test Snippet"
    
    override func setUp() {
        super.setUp()
        
        let story = Story(snippet: snippet, multimedia: [multimedia], headline: headline)
        sut = StoryViewModel(story: story)
        
    }
    
    func test_StoryHeadline(){
        XCTAssertEqual(sut.headline, headline.main)
    }
    
    func test_StorySnippet(){
        XCTAssertEqual(sut.snippet, snippet)
    }
    
    func test_StoryImageURL(){
        XCTAssertEqual(sut.image, URL(string: AppConstants.imgUrl + multimedia.url))
    }
}
