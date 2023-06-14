//
//  MovieModel.swift
//  Netflix_Clone_App
//
//  Created by 초코크림 on 2023/05/31.
//

import Foundation

struct MovieModel: Codable {
    let resultCount: Int
    let results: [MovieResult]
}

struct MovieResult: Codable {
    let trackName: String?
    let previewUrl: String?
    let artworkUrl: String?
    let releaseDate: String?
    let shortDescription: String?
    let longDescription: String?

    enum CodingKeys: String, CodingKey {
        case trackName
        case previewUrl
        case artworkUrl = "artworkUrl100"
        case releaseDate
        case shortDescription
        case longDescription
    }
}
