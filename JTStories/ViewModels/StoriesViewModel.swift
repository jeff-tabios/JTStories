//
//  StoriesViewModel.swift
//  JTStories
//
//  Created by Jeff Tabios on 28/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

protocol AppendableList{
    var lastPageLoaded: Int {get set}
    var query: String {get set}
    func reload(with term:String)
    func getNextPage()
}

class StoriesViewModel: AppendableList {
    var api:APIProtocol?
    var lastPageLoaded = -1
    var query = ""
    var refreshStoryListClosure:(()-> Void)?
    var storyViewModels:[StoryViewModel] = [] {
        didSet{
            self.refreshStoryListClosure?()
        }
    }
    
    init(api:APIProtocol){
        self.api = api
    }
    
    func reload(with term:String = ""){
        lastPageLoaded = -1
        query = term
        storyViewModels = []
        getNextPage()
    }
    
    func getNextPage(){
        api?.request(endPoint: StoryAPI.getStories(page: lastPageLoaded+1,q:query),
                     completion: { [weak self] (result:Result<Stories,APIServiceError>) in
                        switch result{
                        case .success(let stories):
                            self?.lastPageLoaded += 1
                            self?.storyViewModels += stories.response.docs.map{StoryViewModel(story: $0)}
                        case .failure:
                            break
                        }
        })
    }
}
