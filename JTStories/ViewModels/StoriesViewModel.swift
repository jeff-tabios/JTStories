//
//  StoriesViewModel.swift
//  JTStories
//
//  Created by Jeff Tabios on 28/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

class StoriesViewModel {
    var api:APIProtocol?
    private var lastPageLoaded = -1
    private var query = ""
    var refreshStoryListClosure = (()-> Void).self
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
            self?.lastPageLoaded += 1
            self?.storyViewModels += stories.response.docs.map{StoryViewModel(story: $0)}
        })
    }
}
