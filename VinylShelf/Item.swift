//
//  Item.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
