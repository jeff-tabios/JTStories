//
//  StoryViewModel.swift
//  JTStories
//
//  Created by Jeff Tabios on 28/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryDetail{
    var story: Story {get set}
    var image: URL? { get }
    var headline: String? {get }
    var snippet: String? {get }
}

public extension StoryDetail{
    var image: URL? {
        if story.multimedia.count > 0 {
            let imageUrl = story.multimedia[0].url
            return URL(string: AppConstants.imgUrl + imageUrl)
        }
        return nil
    }
    var headline: String? {
        return story.headline.main
    }
    var snippet: String? {
        return story.snippet
    }
}

struct StoryViewModel: StoryDetail {
    
    var story: Story
    
    public init(story: Story){
        self.story = story
    }
}
