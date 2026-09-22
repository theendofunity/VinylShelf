//
//  RandomizerView.swift
//  VinylShelf
//
//  Created by ddudkin on 22. 9. 2026..
//

import SwiftUI

struct RandomizerView: View {
    @StateObject var viewModel: RandomizerViewModel
    
    init(viewModel: RandomizerViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2.0, anchor: .center)
                
                Text("Selecting record")
                    .padding(.top, 24)
                
            case let .ready(record):
                RecordCover(url: record.cover)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)

                VStack(alignment: .leading, spacing: 4) {
                    Text(record.artist)
                        .font(.title).bold()
                    Text(record.album)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

//#Preview {
//    RandomizerView()
//}
