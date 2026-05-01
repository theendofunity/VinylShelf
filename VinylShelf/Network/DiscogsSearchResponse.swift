//
//  DiscogsSearchResponse.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//


import Foundation

struct DiscogsSearchResponse: Decodable {
    let results: [DiscogsSearchResult]
}

struct DiscogsSearchResult: Decodable, Identifiable {
    let id: Int
    let title: String?
    let year: Int?
    let country: String?
    let thumb: String?
    let coverImage: String?
    let resourceUrl: String?
    let type: String?
}