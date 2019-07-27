//
//  Stories.swift
//  JTStories
//
//  Created by Jeff Tabios on 27/07/2019.
//  Copyright © 2019 Jeff Tabios. All rights reserved.
//

import Foundation

// MARK: - Stories
struct Stories: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let docs: [Story]
    let meta: Meta
}

// MARK: - Doc
struct Story: Codable {
    let snippet: String
    let multimedia: [Multimedia]
    let headline: Headline
    let pubDate: Date
    
    enum CodingKeys: String, CodingKey {
        case snippet
        case multimedia, headline
        case pubDate = "pub_date"
    }
}

// MARK: - Headline
struct Headline: Codable {
    let main: String
    
    enum CodingKeys: String, CodingKey {
        case main
    }
}

// MARK: - Multimedia
struct Multimedia: Codable {
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case url
    }
}

// MARK: - Meta
struct Meta: Codable {
    let offset: Int
}