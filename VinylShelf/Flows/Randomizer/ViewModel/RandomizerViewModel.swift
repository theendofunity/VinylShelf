//
//  Untitled.swift
//  VinylShelf
//
//  Created by ddudkin on 22. 9. 2026..
//

import Foundation
import Combine

final class RandomizerViewModel: ObservableObject {
    enum State {
        case loading
        case ready(RandomRecord)
    }
    
    struct RandomRecord {
        var cover: URL?
        var artist: String
        var album: String
    }
    
    @Published var state: State = .loading
    private var records: [Record]
    
    init(records: [Record]) {
        self.records = records
    }
    
    func load() async {
        state = .loading
        await try? Task.sleep(nanoseconds: 300000000)
        
        guard let record = records.randomElement() else {
            return
        }
        
        let model = RandomRecord(cover: record.cover, artist: record.artist, album: record.album)
        state = .ready(model)
    }
}
