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
    var cover: URL?
    var artist: String
    var album: String
    
    init(cover: URL? = nil, artist: String, album: String) {
        self.cover = cover
        self.artist = artist
        self.album = album
    }
}
