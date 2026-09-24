//
//  RecordDetailsViewModel.swift
//  VinylShelf
//
//  Created by Codex on 24. 9. 2026..
//

import SwiftUI
import SwiftData

@Observable
@MainActor
final class RecordDetailsViewModel {
    var isDeleteConfirmationPresented = false

    func move(_ record: Record) {
        withAnimation {
            record.isInWishlist.toggle()
        }
    }

    func requestDelete() {
        isDeleteConfirmationPresented = true
    }

    func delete(_ record: Record, in context: ModelContext) {
        withAnimation {
            context.delete(record)
        }
    }
}
