//
//  StoriesViewModel.swift
//  JTStories
//
//  Created by Jeff Tabios on 28/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation
import UIKit

class StoriesViewModel {
    var api:APIProtocol?
    private var lastPageLoaded = -1
    private var query = ""
    var storyViewModels:[StoryViewModel] = []
    
    init(api:APIProtocol){
        self.api = api
    }
    
    func refresh(with term:String = ""){
        lastPageLoaded = -1
        query = term
        storyViewModels = []
        getNextPage()
    }
    
    func getNextPage(){
        api?.request(endPoint: StoryAPI.getStories(page: lastPageLoaded+1,q:query), completion: { [weak self] (stories:Stories?) in
            guard let stories = stories else { return }
            if let storyVMs = self?.processStories(items: stories.response.docs){
                self?.lastPageLoaded += 1
                self?.storyViewModels += storyVMs
            }
        })
    }
    
    func processStories(items:[Story])->[StoryViewModel]{
        var newItems = [StoryViewModel]()
        for storyItem in items{
            newItems.append(createStoryViewModel(item: storyItem))
        }
        return newItems
    }
    
    func createStoryViewModel(item:Story) -> StoryViewModel{
        let itemVM = StoryViewModel()
        
        if item.multimedia.count > 0 {
            let imageUrl = item.multimedia[0].url
            itemVM.image = UIImage(named: AppConstants.imgUrl + imageUrl)
        }else{
            itemVM.image = nil
        }
        
        itemVM.headline = item.headline.main
        itemVM.snippet = item.snippet
        
        return itemVM
    }
}

class StoryViewModel {
    var image: UIImage?
    var headline: String?
    var snippet: String?
}
