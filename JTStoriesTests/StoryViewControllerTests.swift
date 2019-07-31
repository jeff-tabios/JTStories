//
//  StoryViewControllerTests.swift
//  JTStoriesTests
//
//  Created by Jeff Tabios on 31/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import XCTest
@testable import JTStories

class StoryViewControllerTests: XCTestCase {
    var sut: StoryViewController!
    let multimedia = Multimedia(url: "images/2019/04/01/world/01singapore-1/merlin_152920632_816eb94d-089d-4fe5-be33-d05de16f88f9-articleLarge.jpg")
    let headline = Headline(main: "Test Headline")
    let snippet = "Test Snippet"
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        sut = storyboard.instantiateViewController(withIdentifier: "StoryViewController") as? StoryViewController
        let story = Story(snippet: snippet, multimedia: [multimedia], headline: headline)
        sut.storyViewModel = StoryViewModel(story: story)
        let _ = sut.view
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_StoryContentPlacement(){
        XCTAssertEqual(sut.headline.text, headline.main)
        XCTAssertEqual(sut.snippet.text, snippet)
        XCTAssertEqual(sut.storyViewModel?.image, URL(string: AppConstants.imgUrl + multimedia.url))
    }
    

}
