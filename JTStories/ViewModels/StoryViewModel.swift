//
//  StoryViewModel.swift
//  JTStories
//
//  Created by Jeff Tabios on 28/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class StoryViewModel {
    private let story: Story
    
    public init(story: Story){
        self.story = story
    }
    
    var image: UIImage? {
        if story.multimedia.count > 0 {
            let imageUrl = story.multimedia[0].url
            return UIImage(named: AppConstants.imgUrl + imageUrl)
        }
        return nil
    }
    var headline: String {
        return story.headline.main
    }
    var snippet: String {
        return story.snippet
    }
    
}
