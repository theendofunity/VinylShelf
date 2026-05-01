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
        NavigationSplitView {
            List {
                ForEach(records) { record in
                    NavigationLink {
                        Text(record.artist)
                        Text(record.album)
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
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $viewModel.showSheet) {
            addBottomSheet()
        }
    }

    @ViewBuilder private func addBottomSheet() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            AddOptionButton(buttonType: .scan) {
                viewModel.dismissSheet()
                viewModel.addTestItem(in: modelContext)
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
