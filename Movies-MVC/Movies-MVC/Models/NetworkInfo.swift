// NetworkInfo.swift
// Copyright © RoadMap. All rights reserved.

// Модель для получения данных по фильмам
struct Results: Codable {
    let movies: [Movie]
}

// Модель для получения данных по фильму
struct Movie: Codable {
    let overview: String
    let releaseDate: String
    let poster: String
    let title: String
    let voteAverage: Float
    let id: Int

    enum CodingKeys: String, CodingKey {
        case overview
        case releaseDate = "release_date"
        case poster = "poster_path"
        case title
        case voteAverage = "vote_average"
        case id
    }
}
