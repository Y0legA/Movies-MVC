// MovieInfo.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// описание модели для ячейки фильмов
struct MovieInfo {
    let posterName: String
    let titleName: String
    let descriptionName: String
    let ratingName: String
    let relizeName: String

    init(_ name: String, _ text: String, _ description: String, _ rating: String, _ relize: String) {
        posterName = name
        titleName = text
        descriptionName = description
        ratingName = rating
        relizeName = relize
    }
}
