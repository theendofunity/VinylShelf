//
//  DiscogsRelease.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//


import Foundation

struct DiscogsRelease: Decodable, Identifiable {
    let id: Int
    let title: String
    let year: Int?
    let country: String?
    let released: String?
    let artists: [DiscogsArtist]?
    let labels: [DiscogsLabel]?
    let formats: [DiscogsFormat]?
    let tracklist: [DiscogsTrack]?
    let images: [DiscogsImage]?
    let identifiers: [DiscogsIdentifier]?
}

struct DiscogsArtist: Decodable {
    let name: String
}

struct DiscogsLabel: Decodable {
    let name: String
    let catno: String?
}

struct DiscogsFormat: Decodable {
    let name: String?
    let qty: String?
    let descriptions: [String]?
}

struct DiscogsTrack: Decodable {
    let position: String?
    let title: String?
    let duration: String?
    let trackType: String?

    enum CodingKeys: String, CodingKey {
        case position, title, duration
        case trackType = "type_"
    }
}

struct DiscogsImage: Decodable {
    let type: String?
    let uri: String?
    let resourceUrl: String?
    let uri150: String?
}

struct DiscogsIdentifier: Decodable {
    let type: String?
    let value: String?
}