//
//  MainViewModel.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import SwiftUI
import SwiftData

@Observable
final class MainViewModel {
    var showSheet = false

    func showAddSheet() {
        showSheet = true
    }

    func dismissSheet() {
        showSheet = false
    }

    func addTestItem(in context: ModelContext) {
        withAnimation {
            let newItem = Record(artist: "Artist", album: "Album")
            context.insert(newItem)
        }
    }

    func deleteItems(offsets: IndexSet, from records: [Record], in context: ModelContext) {
        withAnimation {
            for index in offsets {
                context.delete(records[index])
            }
        }
    }
}
