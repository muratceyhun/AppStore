//
//  ReviewResult.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 12.05.2023.
//

import Foundation

struct Reviews: Decodable {
    let feed: FeedResult
}

struct FeedResult: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: Icon
    let content: Content
    let rating: Icon
    
    
    enum CodingKeys: String, CodingKey {
        case author, title, content
        case rating = "im:rating"
    }
}



struct Author: Decodable {
    let name: Icon
}

struct Icon: Decodable {
    let label: String?
}

struct Content: Decodable {
    let label: String?
}

