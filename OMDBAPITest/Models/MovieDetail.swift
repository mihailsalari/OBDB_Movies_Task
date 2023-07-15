//
//  MovieDetail.swift
//  OMDBAPITest
//
//  Created by Mihail Salari on 7/15/23.
//

import Foundation

struct MovieDetail: Codable {
    let title, year, rated, released: String
    let runtime, genre, director, writer: String
    let actors, plot, language, country: String
    let awards: String
    let poster: String
    let ratings: [MovieRating]
    let metascore, imdbRating, imdbVotes, imdbID: String
    let type: String
    let response: String
    var dvd, boxOffice, website, production: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case rated = "Rated"
        case released = "Released"
        case runtime = "Runtime"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case country = "Country"
        case awards = "Awards"
        case poster = "Poster"
        case ratings = "Ratings"
        case metascore = "Metascore"
        case imdbRating, imdbVotes, imdbID
        case type = "Type"
        case dvd = "DVD"
        case boxOffice = "BoxOffice"
        case production = "Production"
        case website = "Website"
        case response = "Response"
    }
}

struct MovieRating: Codable {
    let source, value: String

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

/*
 {
    "Title":"Batman Begins",
    "Year":"2005",
    "Rated":"PG-13",
    "Released":"15 Jun 2005",
    "Runtime":"140 min",
    "Genre":"Action, Crime, Drama",
    "Director":"Christopher Nolan",
    "Writer":"Bob Kane, David S. Goyer, Christopher Nolan",
    "Actors":"Christian Bale, Michael Caine, Ken Watanabe",
    "Plot":"When his parents are killed, billionaire playboy Bruce Wayne relocates to Asia, where he is mentored by Henri Ducard and Ra's Al Ghul in how to fight evil. When learning about the plan to wipe out evil in Gotham City by Ducard, Bruce prevents this plan from getting any further and heads back to his home. Back in his original surroundings, Bruce adopts the image of a bat to strike fear into the criminals and the corrupt as the icon known as \"Batman\". But it doesn't stay quiet for long.",
    "Language":"English, Mandarin",
    "Country":"United States, United Kingdom",
    "Awards":"Nominated for 1 Oscar. 14 wins & 79 nominations total",
    "Poster":"https://m.media-amazon.com/images/M/MV5BOTY4YjI2N2MtYmFlMC00ZjcyLTg3YjEtMDQyM2ZjYzQ5YWFkXkEyXkFqcGdeQXVyMTQxNzMzNDI@._V1_SX300.jpg",
    "Ratings":[
       {
          "Source":"Internet Movie Database",
          "Value":"8.2/10"
       },
       {
          "Source":"Rotten Tomatoes",
          "Value":"84%"
       },
       {
          "Source":"Metacritic",
          "Value":"70/100"
       }
    ],
    "Metascore":"70",
    "re":"8.2",
    "imdbVotes":"1,507,891",
    "imdbID":"tt0372784",
    "Type":"movie",
    "DVD":"18 Oct 2005",
    "BoxOffice":"$206,863,479",
    "Production":"N/A",
    "Website":"N/A",
    "Response":"True"
 }
 */
