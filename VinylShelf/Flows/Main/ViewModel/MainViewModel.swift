//
//  MainViewModel.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import SwiftUI
import SwiftData

@Observable
@MainActor
final class MainViewModel {
    var showSheet = false
    var showScanner = false
    var isLoadingRecord = false
    var scanError: Error?

    private let discogs = DiscogsClient(
        config: DiscogsConfig(
            key: Secrets.discogsKey,
            secret: Secrets.discogsSecret,
            appName: "VinylShelf",
            appVersion: "1.0"
        )
    )

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
        isLoadingRecord = true
        scanError = nil

        var formattedBarcode: String = barcode
        
        if formattedBarcode.first == "0" {
            formattedBarcode.removeFirst()
        }
        
        Task {
            do {
                let results = try await discogs.searchRelease(barcode: formattedBarcode)
                guard let first = results.first else {
                    throw DiscogsError.emptyResult
                }
                let (artist, album) = parseDiscogsTitle(first.title ?? formattedBarcode)
                let coverURL = [first.coverImage, first.thumb]
                    .compactMap { $0 }
                    .compactMap(URL.init)
                    .first
                withAnimation {
                    context.insert(Record(cover: coverURL, artist: artist, album: album))
                }
            } catch {
                scanError = error
            }
            isLoadingRecord = false
        }
    }

    func addTestItem(in context: ModelContext) {
        withAnimation {
            let newItem = Record(artist: "Long artust name", album: "Long album name Album")
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

    // Discogs search titles are formatted as "Artist - Album Title"
    private func parseDiscogsTitle(_ title: String) -> (artist: String, album: String) {
        let parts = title.components(separatedBy: " - ")
        guard parts.count >= 2 else { return ("Unknown", title) }
        return (parts[0], parts[1...].joined(separator: " - "))
    }
}
