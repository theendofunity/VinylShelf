//
//  Strings.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

enum Texts {
    static let mainTitle = "Collection"
    static let detailsTitle = "Explore"

    static let addBottomSheetScan = "Scan"
    static let addBottomSheetSearch = "Search"
    static let addBottomSheetScanDescription = "Scan barcode from your record"
    static let addBottomSheetSearchDescription = "Manual search by artist and album"
    static let cancel = "Cancel"

    static let scannerHint = "Align the barcode within the frame"

    static let recordDetailsTracklist = "Tracklist"
    static let recordDetailsSpotifyButton = "Open in Spotify"

    static let scanLookingUp = "Looking up record…"
    static let scanErrorTitle = "Record Not Found"
    static let scanErrorOK = "OK"
    static let scanErrorEmpty = "No record found for this barcode."
    static let scanErrorNetwork = "Could not fetch record details."
    static func scanErrorHTTP(_ code: Int) -> String { "Discogs API error (\(code))." }

    static let successScanAddToCollectionButton = "Save to Collection"
    static let successScanAddToWishlistButton = "Add to Wishlist"
}
