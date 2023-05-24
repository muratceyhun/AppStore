//
//  AppGroup.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 4.05.2023.
//

import Foundation

struct AppGroup: Decodable {
    var feed: Feed
}

struct Feed: Decodable {
    let title: String
    var results: [AppResult]
}

struct AppResult: Decodable {
    let name: String
    let artworkUrl100: String
    let artistName: String
    let id: String
}
