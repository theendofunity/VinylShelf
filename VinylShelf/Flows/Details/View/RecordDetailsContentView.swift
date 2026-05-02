//
//  RecordDetailsContentView.swift
//  VinylShelf
//
//  Created by ddudkin on 2. 5. 2026..
//

import SwiftUI

struct RecordDetailsContentView: View {
    let record: Record
    
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
                }
                .padding()

                if !record.tracklist.isEmpty {
                    Divider()

                    VStack(alignment: .leading, spacing: 0) {
                        Text("Tracklist")
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
