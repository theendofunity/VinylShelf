//
//  RecordCover.swift
//  VinylShelf
//
//  Created by ddudkin on 2. 5. 2026..
//

import SwiftUI

struct RecordCover: View {
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .failure, .empty:
                Image("coverPlaceholder")
                    .resizable()
            @unknown default:
                Image("coverPlaceholder")
                    .resizable()
            }
        }
    }
}

#Preview {
    RecordCover(url: nil)
}
