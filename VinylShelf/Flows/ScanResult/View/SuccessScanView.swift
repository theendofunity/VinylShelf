//
//  SuccessScanView.swift
//  VinylShelf
//
//  Created by ddudkin on 2. 5. 2026..
//

import SwiftUI

struct SuccessScanView: View {
    let record: Record
    let onSave: () -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .bottom) {
            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color.black.opacity(0.35), in: Circle())
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 16)
                }
                Spacer()
            }
            .zIndex(1)
            RecordDetailsContentView(record: record)
                .safeAreaInset(edge: .top) {
                    Color.clear.frame(height: 52)
                }
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 140)
                }

            VStack(spacing: 12) {
                Button {
                    onSave()
                    dismiss()
                } label: {
                    Label(
                        Texts.successScanAddToCollectionButton,
                        systemImage: "plus.circle.fill"
                    )
                    .frame(
                        maxWidth: .infinity
                    )
                }
                .buttonStyle(.glassProminent)

//                Button {
//                } label: {
//                    Label(
//                        Texts.successScanAddToWishlistButton,
//                        systemImage: "heart"
//                    )
//                        .frame(maxWidth: .infinity)
//                }
//                .buttonStyle(.glass)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
            .background {
                LinearGradient(
                    colors: [.clear, Color(.systemBackground)],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    SuccessScanView(record: .sample()) {}
}
