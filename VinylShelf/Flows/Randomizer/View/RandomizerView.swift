//
//  RandomizerView.swift
//  VinylShelf
//
//  Created by ddudkin on 22. 9. 2026..
//

import SwiftUI

struct RandomizerView: View {
    @StateObject var viewModel: RandomizerViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(viewModel: RandomizerViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()

                Button(role: .close) {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.monochrome)
                        .foregroundStyle(Color.primary)
                        .font(.title)
                        .padding()
                }

            }
            .padding(.top, 16)

            switch viewModel.state {
            case .loading:
                Spacer()
                
                ProgressView("Selecting record")
                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                    .scaleEffect(2.0, anchor: .center)
                
                Spacer()

            case let .ready(record):
                Text("Your random record")
                    .font(.title)
                

                RecordCover(url: record.cover)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(.top, 24)

                VStack(alignment: .leading, spacing: 4) {
                    Text(record.artist)
                        .font(.title).bold()
                    Text(record.album)
                        .font(.title2)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Button(role: .confirm) {
                    Task {
                        await viewModel.load()
                    }
                } label: {
                    Text("Try again")
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 16)
                .buttonStyle(.glassProminent)
            }
        }
        .task {
            await viewModel.load()
        }
    }
}

#Preview {
    PreviewContainer()
}

private struct PreviewContainer: View {
    @State private var isPresented = true

    var body: some View {
        Color.clear
            .sheet(isPresented: $isPresented) {
                RandomizerView(viewModel: .init(records: [.sample()]))
            }
    }
}
