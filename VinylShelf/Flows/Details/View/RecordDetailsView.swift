//
//  RecordDetailsView.swift
//  VinylShelf
//
//  Created by ddudkin on 2. 5. 2026..
//

import SwiftUI
import SwiftData

struct RecordDetailsView: View {
    let record: Record

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = RecordDetailsViewModel()

    var body: some View {
        RecordDetailsContentView(record: record)
            .navigationTitle(Texts.detailsTitle)
            .navigationBarTitleDisplayMode(.inline)
            .safeAreaInset(edge: .bottom) {
                VStack(spacing: 12) {
                    Button {
                        viewModel.move(record)
                        dismiss()
                    } label: {
                        Label(
                            record.isInWishlist
                                ? Texts.recordDetailsMoveToCollectionButton
                                : Texts.recordDetailsMoveToWishlistButton,
                            systemImage: record.isInWishlist ? "square.stack.3d.up.fill" : "heart.fill"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.glassProminent)

                    Button(role: .destructive) {
                        viewModel.requestDelete()
                    } label: {
                        Label(Texts.recordDetailsDeleteButton, systemImage: "trash")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.glass)
                    .tint(.red)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .background(.ultraThinMaterial)
            }
            .confirmationDialog(
                Texts.recordDetailsDeleteTitle,
                isPresented: $viewModel.isDeleteConfirmationPresented,
                titleVisibility: .visible
            ) {
                Button(Texts.recordDetailsDeleteButton, role: .destructive) {
                    viewModel.delete(record, in: modelContext)
                    dismiss()
                }
                Button(Texts.cancel, role: .cancel) {}
            } message: {
                Text(Texts.recordDetailsDeleteMessage)
            }
    }
}

#Preview {
    NavigationStack {
        RecordDetailsView(record: Record.sample())
    }
    .modelContainer(for: Record.self, inMemory: true)
}
