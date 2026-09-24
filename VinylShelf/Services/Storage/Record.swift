//
//  Item.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Record {
    var discogsId: Int?
    var cover: URL?
    var artist: String
    var album: String
    var year: Int?
    var country: String?
    var label: String?
    var tracklist: [String]
    var isInWishlist: Bool = false 

    init(
        discogsId: Int? = nil,
        cover: URL? = nil,
        artist: String,
        album: String,
        year: Int? = nil,
        country: String? = nil,
        label: String? = nil,
        tracklist: [String] = [],
        isInWishlist: Bool = false
    ) {
        self.discogsId = discogsId
        self.cover = cover
        self.artist = artist
        self.album = album
        self.year = year
        self.country = country
        self.label = label
        self.tracklist = tracklist
        self.isInWishlist = isInWishlist
    }
}

extension Record {
    static func sample() -> Record {
        .init(
            artist: "Nirvana",
            album: "Nevermind",
            year: 1991,
            country: "US",
            label: "DGC Records",
            tracklist: [
                "1. Smells Like Teen Spirit (5:01)",
                "2. In Bloom (4:14)",
                "3. Come as You Are (3:38)"
            ]
        )
    }
}
