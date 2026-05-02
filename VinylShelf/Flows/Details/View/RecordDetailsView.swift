//
//  RecordDetailsView.swift
//  VinylShelf
//
//  Created by ddudkin on 2. 5. 2026..
//

import SwiftUI

struct RecordDetailsView: View {
    let record: Record

    var body: some View {
        RecordDetailsContentView(record: record)
            .navigationTitle(Texts.detailsTitle)
            .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        RecordDetailsView(record: Record.sample())
    }
}
