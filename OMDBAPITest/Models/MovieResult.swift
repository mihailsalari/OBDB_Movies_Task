//
//  MovieResult.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/14/23.
//

import Foundation

struct MovieResult: Codable {
    var search: [MovieSearch]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct MovieSearch: Codable {
    let title, year, imdbID: String
    let type: MovieType
    let poster: String

    var posterImage: Data?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}

enum MovieType: String, Codable {
    case movie = "movie"
    case series = "series"
}
