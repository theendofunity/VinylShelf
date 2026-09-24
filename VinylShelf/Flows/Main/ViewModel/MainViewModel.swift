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
    var isAddSheetVisible = false
    var isRandomizerVisible = false
    var showScanner = false
    var isLoadingRecord = false
    var scanError: Error?
    var pendingRecord: Record?
    var isWishlist: Bool = false
    
    private let discogs = DiscogsClient(
        config: DiscogsConfig(
            key: Secrets.discogsKey,
            secret: Secrets.discogsSecret,
            appName: "VinylShelf",
            appVersion: "1.0"
        )
    )

    func visibleRecords(collection: [Record], wishlist: [Record]) -> [Record] {
        isWishlist ? wishlist : collection
    }
    
    func showAddSheet() {
        isAddSheetVisible = true
    }

    func dismissSheet() {
        isAddSheetVisible = false
    }

    func openScanner() {
        isAddSheetVisible = false
        showScanner = true
    }

    func dismissScanner() {
        showScanner = false
    }
    
    func showRandomizer() {
        isRandomizerVisible = true
    }

    func handleScannedBarcode(_ barcode: String) {
        showScanner = false
        isLoadingRecord = true
        scanError = nil

        var formattedBarcode = barcode
        if formattedBarcode.first == "0" {
            formattedBarcode.removeFirst()
        }

        Task {
            do {
                let results = try await discogs.searchRelease(barcode: formattedBarcode)
                guard let first = results.first else {
                    throw DiscogsError.emptyResult
                }
                let release = try await discogs.release(id: first.id)
                pendingRecord = record(from: release, fallbackSearchResult: first)
            } catch {
                scanError = error
            }
            isLoadingRecord = false
        }
    }

    func saveRecord(in context: ModelContext, isWishlist: Bool) {
        guard let record = pendingRecord else { return }
        record.isInWishlist = isWishlist
        withAnimation {
            context.insert(record)
        }
        pendingRecord = nil
    }

    func discardRecord() {
        pendingRecord = nil
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

    private func record(from release: DiscogsRelease, fallbackSearchResult: DiscogsSearchResult) -> Record {
        let artist = release.artists?.first?.name
            ?? parseDiscogsTitle(fallbackSearchResult.title ?? release.title).artist

        let coverURL = release.images?
            .first(where: { $0.type == "primary" })
            .flatMap { $0.uri.flatMap(URL.init) }
            ?? [fallbackSearchResult.coverImage, fallbackSearchResult.thumb]
                .compactMap { $0 }
                .compactMap(URL.init)
                .first

        let tracklist = (release.tracklist ?? [])
            .filter { $0.trackType == "track" || $0.trackType == nil }
            .map { track -> String in
                var entry = [track.position, track.title]
                    .compactMap { $0 }
                    .filter { !$0.isEmpty }
                    .joined(separator: ". ")
                if let duration = track.duration, !duration.isEmpty {
                    entry += " (\(duration))"
                }
                return entry
            }

        return Record(
            discogsId: release.id,
            cover: coverURL,
            artist: artist,
            album: release.title,
            year: release.year,
            country: release.country,
            label: release.labels?.first?.name,
            tracklist: tracklist
        )
    }

    // Discogs search titles are formatted as "Artist - Album Title"
    private func parseDiscogsTitle(_ title: String) -> (artist: String, album: String) {
        let parts = title.components(separatedBy: " - ")
        guard parts.count >= 2 else { return ("Unknown", title) }
        return (parts[0], parts[1...].joined(separator: " - "))
    }
}
