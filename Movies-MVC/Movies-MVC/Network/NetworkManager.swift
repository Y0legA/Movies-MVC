// NetworkManager.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

// Сетевой слой
final class NetworkManager {
    private enum Constants {
        static let apikey = "api_key"
        static let language = "language"
        static let id = "id"
        static let page = "page"
    }

    // MARK: - Public methods

    func fetchMoviesResult(
        _ estimateUrl: String,
        _ currentPage: Int,
        completion: @escaping (Result<Results, Error>) -> ()
    ) {
        let urlString = Url.baseUrl + estimateUrl
        guard var url = URL(string: urlString) else { return }
        url.append(queryItems: [
            URLQueryItem(name: Constants.apikey, value: Url.apiKey),
            URLQueryItem(name: Constants.language, value: Url.suffixRu),
            URLQueryItem(name: Constants.page, value: String(currentPage))
        ])
        getJson(url: url, completion: completion)
    }

    func fetchCreditsResult(_ id: Int, completion: @escaping (Result<Detail, Error>) -> ()) {
        let urlString = Url.baseUrl + Url.movie + String(id) + Url.credits
        guard var url = URL(string: urlString) else { return }
        url.append(queryItems: [
            URLQueryItem(name: Constants.apikey, value: Url.apiKey)
        ])
        getJson(url: url, completion: completion)
    }

    func fetchTiserResult(_ id: String, completion: @escaping (Result<Tiser, Error>) -> ()) {
        let urlString = Url.baseUrl + Url.movie + id + Url.videos
        guard var url = URL(string: urlString) else { return }
        url.append(queryItems: [
            URLQueryItem(name: Constants.apikey, value: Url.apiKey)
        ])
        getJson(url: url, completion: completion)
    }

    // MARK: - Private methods

    private func getJson<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> ()) {
        let session = URLSession.shared
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else { return }
            do {
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
