// NetworkDetail.swift
// Copyright © RoadMap. All rights reserved.

// Модель для получения данных по актерам
struct Detail: Codable {
    let casts: [Cast]?
}

// Модель для получения данных по актеру
struct Cast: Codable {
    let name: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case name = "original_name"
        case profilePath = "profile_path"
    }
}
