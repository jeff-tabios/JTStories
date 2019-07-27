//
//  MovieAPI.swift
//  JTMovies
//
//  Created by Jeff Tabios on 24/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

enum StoryAPI {
    case getStories(page:Int,q:String)
}

extension StoryAPI: EndPoint {
    var apiKey: String { return "4nXMkAqbt5gKaHvB1nO8TCTo54r26AAA" }
    
    var baseURL: String {
        return "https://api.nytimes.com/svc/search/v2/articlesearch.json"
    }
    
    var path: String {
        return ""
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return [:]
    }
    
    var params: Parameters {
        var items = Parameters()
        items["api-key"]=apiKey
        
        switch self {
        case .getStories(let page,let q):
            items["page"]="\(page)"
            items["q"]=q
        }
        return items
    }
}
