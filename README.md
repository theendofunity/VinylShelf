# VinylShelf

An iOS app for cataloguing your vinyl record collection. Scan a barcode and VinylShelf looks up the release on Discogs — artwork, tracklist, label, and year — then lets you jump straight to it in Spotify.

## Features

- **Barcode scanning** — point the camera at any vinyl barcode (EAN-13, UPC-A/E, Code-128)
- **Discogs lookup** — fetches full release details: artist, album, year, country, label, cover art, and tracklist
- **Collection management** — save records to your local collection or add to a wishlist
- **Spotify integration** — opens the exact album in Spotify directly from the detail view
- **Persistent storage** — collection is stored locally via SwiftData

## Requirements

- iOS 18+
- Xcode 16+
- Discogs account

## Architecture

MVVM with SwiftUI + SwiftData.

```
VinylShelf/
├── AppStart/               # App entry point
├── Flows/
│   ├── Main/               # Collection list
│   ├── Scanner/            # Barcode scanner (AVFoundation)
│   ├── ScanResult/         # Post-scan confirmation screen
│   └── Details/            # Record detail view
├── Services/
│   ├── Network/            # DiscogsClient, SpotifyClient
│   └── Storage/            # Record model (SwiftData)
├── Helpers/                # Shared constants
└── Resources/              # Secrets, assets
```

### Scan flow

1. Camera captures a barcode → `BarcodeScannerView` fires the `onScan` callback
2. `MainViewModel` strips a leading zero if present, then calls `DiscogsClient.searchRelease(barcode:)`
3. The first search result's ID is used to fetch the full release via `DiscogsClient.release(id:)`
4. A `Record` is constructed and held as `pendingRecord` — not yet saved
5. `SuccessScanView` is presented; tapping **Save to Collection** inserts the record into SwiftData
