// TiserInfo.swift
// Copyright © RoadMap. All rights reserved.

// Модель для получения данных по тизеру
struct Tiser: Codable {
    let results: [TiserDetail]?
}

///
struct TiserDetail: Codable {
    let key: String

    enum CodingKeys: String, CodingKey {
        case key
    }
}
