//
//  Strings.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

enum Texts {
    static let mainTitle = "Collection"
    static let wishlistTitle = "Wishlist"
    static let detailsTitle = "Explore"
    static func recordsCount(_ count: Int) -> String {
        count == 1 ? "1 record" : "\(count) records"
    }

    static let addBottomSheetScan = "Scan"
    static let addBottomSheetSearch = "Search"
    static let addBottomSheetScanDescription = "Scan barcode from your record"
    static let addBottomSheetSearchDescription = "Manual search by artist and album"
    static let cancel = "Cancel"

    static let scannerHint = "Align the barcode within the frame"

    static let recordDetailsTracklist = "Tracklist"
    static let recordDetailsSpotifyButton = "Open in Spotify"
    static let recordDetailsMoveToCollectionButton = "Move to Collection"
    static let recordDetailsMoveToWishlistButton = "Move to Wishlist"
    static let recordDetailsDeleteButton = "Delete Record"
    static let recordDetailsDeleteTitle = "Delete this record?"
    static let recordDetailsDeleteMessage = "This action cannot be undone."

    static let scanLookingUp = "Looking up record…"
    static let scanErrorTitle = "Record Not Found"
    static let scanErrorOK = "OK"
    static let scanErrorEmpty = "No record found for this barcode."
    static let scanErrorNetwork = "Could not fetch record details."
    static func scanErrorHTTP(_ code: Int) -> String { "Discogs API error (\(code))." }

    static let successScanAddToCollectionButton = "Save to Collection"
    static let successScanAddToWishlistButton = "Add to Wishlist"
    
    static let randomizerLoader = "Selecting record"
    static let randomizerTitle = "Your random record"
    static let tryAgainButton = "Try again"

}
