//
//  SearchResult.swift
//  AppStore
//
//  Created by Murat Ceyhun Korpeoglu on 28.04.2023.
//

import Foundation


struct SearchResult: Decodable {
    let resultCount: Int?
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String?
    let primaryGenreName: String?
    let averageUserRating: Float?
    var screenshotUrls: [String]
    let artworkUrl100: String?
    let formattedPrice: String?
    let description: String?
    let releaseNotes: String?
    let artistName: String?
}
