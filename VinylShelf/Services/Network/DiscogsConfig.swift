//
//  DiscogsConfig.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import Foundation

// MARK: - Config

struct DiscogsConfig {
    let key: String
    let secret: String
    let userAgent: String

    init(key: String, secret: String, appName: String, appVersion: String) {
        self.key = key
        self.secret = secret
        self.userAgent = "\(appName)/\(appVersion)"
    }
}

// MARK: - Errors

enum DiscogsError: Error {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case emptyResult
}

// MARK: - Client

final class DiscogsClient {
    private let config: DiscogsConfig
    private let session: URLSession
    private let baseURL = URL(string: "https://api.discogs.com")!

    init(
        config: DiscogsConfig,
        session: URLSession = .shared
    ) {
        self.config = config
        self.session = session
    }

    // MARK: Public

    func searchRelease(
        artist: String,
        album: String
    ) async throws -> [DiscogsSearchResult] {
        try await request(
            path: "/database/search",
            queryItems: [
                .init(name: "type", value: "release"),
                .init(name: "artist", value: artist),
                .init(name: "release_title", value: album)
            ],
            responseType: DiscogsSearchResponse.self
        ).results
    }

    func searchRelease(
        barcode: String
    ) async throws -> [DiscogsSearchResult] {
        try await request(
            path: "/database/search",
            queryItems: [
                .init(name: "type", value: "release"),
                .init(name: "barcode", value: barcode)
            ],
            responseType: DiscogsSearchResponse.self
        ).results
    }

    func release(id: Int) async throws -> DiscogsRelease {
        try await request(
            path: "/releases/\(id)",
            queryItems: [],
            responseType: DiscogsRelease.self
        )
    }

    // MARK: Private

    private func request<T: Decodable>(
        path: String,
        queryItems: [URLQueryItem],
        responseType: T.Type
    ) async throws -> T {
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )

        components?.queryItems = queryItems + [
            .init(name: "key", value: config.key),
            .init(name: "secret", value: config.secret)
        ]

        guard let url = components?.url else {
            throw DiscogsError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(config.userAgent, forHTTPHeaderField: "User-Agent")

        let (data, response) = try await session.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw DiscogsError.invalidResponse
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw DiscogsError.httpError(httpResponse.statusCode)
        }

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return try decoder.decode(T.self, from: data)
    }
}
