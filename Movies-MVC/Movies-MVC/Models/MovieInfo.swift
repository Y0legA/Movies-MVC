// MovieInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// описание модели для ячейки фильмов
struct MovieInfo {
    let name: String
    let text: String
    let description: String
    let rating: String
    let relize: String

    init(_ name: String, _ text: String, _ description: String, _ rating: String, _ relize: String) {
        self.name = name
        self.text = text
        self.description = description
        self.rating = rating
        self.relize = relize
    }
}
