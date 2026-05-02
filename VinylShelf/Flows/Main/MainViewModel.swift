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
    var showScanner = false

    func showAddSheet() {
        showSheet = true
    }

    func dismissSheet() {
        showSheet = false
    }

    func openScanner() {
        showSheet = false
        showScanner = true
    }

    func dismissScanner() {
        showScanner = false
    }

    func handleScannedBarcode(_ barcode: String, in context: ModelContext) {
        showScanner = false
        // TODO: look up the barcode via DiscogsClient and insert the result
        withAnimation {
            let newItem = Record(artist: "Unknown", album: barcode)
            context.insert(newItem)
        }
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
