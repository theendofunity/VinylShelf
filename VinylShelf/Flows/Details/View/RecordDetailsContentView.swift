//
//  RecordDetailsContentView.swift
//  VinylShelf
//
//  Created by ddudkin on 2. 5. 2026..
//

import SwiftUI

struct RecordDetailsContentView: View {
    let record: Record
    @Environment(\.openURL) private var openURL

    private var spotifySearchURL: URL? {
        let query = "\(record.artist) \(record.album)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        return URL(string: "https://open.spotify.com/search/\(query)")
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                RecordCover(url: record.cover)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)

                VStack(alignment: .leading, spacing: 4) {
                    Text(record.artist)
                        .font(.title).bold()
                    Text(record.album)
                        .font(.title2)
                        .foregroundStyle(.secondary)

                    HStack(spacing: 12) {
                        if let year = record.year {
                            Label(String(year), systemImage: "calendar")
                        }
                        if let country = record.country {
                            Label(country, systemImage: "globe")
                        }
                        if let label = record.label {
                            Label(label, systemImage: "building.2")
                        }
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)

                    if let url = spotifySearchURL {
                        Button {
                            openURL(url)
                        } label: {
                            Label(
                                Texts.recordDetailsSpotifyButton,
                                systemImage: "music.note"
                            )
                                .font(.subheadline.weight(.semibold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(Color(red: 0.11, green: 0.73, blue: 0.33), in: Capsule())
                        }
                        .padding(.top, 8)
                    }
                }
                .padding()

                if !record.tracklist.isEmpty {
                    Divider()

                    VStack(alignment: .leading, spacing: 0) {
                        Text(Texts.recordDetailsTracklist)
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.vertical, 12)

                        ForEach(Array(record.tracklist.enumerated()), id: \.offset) { _, track in
                            Text(track)
                                .font(.body)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                            Divider()
                                .padding(.leading)
                        }
                    }
                }
            }
        }
    }
}
