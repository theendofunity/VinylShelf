//
//  MainView.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var records: [Record]
    @State private var viewModel = MainViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(records) { record in
                    NavigationLink {
                        RecordDetailsView(record: record)
                    } label: {
                        RecordCell(record: record)
                    }
                }
                .onDelete { offsets in
                    viewModel.deleteItems(offsets: offsets, from: records, in: modelContext)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        viewModel.showAddSheet()
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle(Texts.mainTitle)
        }
        .sheet(isPresented: $viewModel.showSheet) {
            addBottomSheet()
        }
        .fullScreenCover(isPresented: $viewModel.showScanner) {
            BarcodeScannerView {
                viewModel.handleScannedBarcode($0)
            } onCancel: {
                viewModel.dismissScanner()
            }
            .ignoresSafeArea()
        }
        .fullScreenCover(item: $viewModel.pendingRecord) { record in
            SuccessScanView(record: record) {
                viewModel.saveRecord(in: modelContext)
            }
        }
        .overlay {
            if viewModel.isLoadingRecord {
                ZStack {
                    Color.black.opacity(0.4).ignoresSafeArea()
                    VStack(spacing: 12) {
                        ProgressView()
                            .tint(.white)
                            .scaleEffect(1.5)
                        Text("Looking up record…")
                            .foregroundStyle(.white)
                            .font(.subheadline)
                    }
                    .padding(24)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .alert("Record Not Found", isPresented: Binding(
            get: { viewModel.scanError != nil },
            set: { if !$0 { viewModel.scanError = nil } }
        )) {
            Button("OK", role: .cancel) { viewModel.scanError = nil }
        } message: {
            Text(viewModel.scanError.map { errorMessage($0) } ?? "")
        }
    }

    private func errorMessage(_ error: Error) -> String {
        if let discogsError = error as? DiscogsError {
            switch discogsError {
            case .emptyResult: return "No record found for this barcode."
            case .httpError(let code): return "Discogs API error (\(code))."
            default: return "Could not fetch record details."
            }
        }
        return error.localizedDescription
    }

    @ViewBuilder private func addBottomSheet() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            AddOptionButton(buttonType: .scan) {
                viewModel.openScanner()
            }

            AddOptionButton(buttonType: .search) {
                viewModel.dismissSheet()
                viewModel.addTestItem(in: modelContext)
            }

            AddOptionButton(buttonType: .cancel, separator: false) {
                viewModel.dismissSheet()
            }
        }
        .presentationDetents([.fraction(0.25)])
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
}

#Preview {
    MainView()
        .modelContainer(for: Record.self, inMemory: true)
}
