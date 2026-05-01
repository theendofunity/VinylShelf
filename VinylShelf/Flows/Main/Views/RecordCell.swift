//
//  RecordCell.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import SwiftUI

struct RecordCell: View {
    let record: Record
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
                Image("coverPlaceholder")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack {
                    Text(record.artist)
                        .font(.headline)
                    Text(record.album)
                        .font(.subheadline)
                    
                }
                
                Spacer()
            }
    }
}

#Preview {
    RecordCell(record: .init(artist: "Artist", album: "Album"))
}
