//
//  ContentView.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import SwiftUI
import SwiftData

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Record]
    @State private var showSheet = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text(item.artist)
                        Text(item.album)
                    } label: {
                        RecordCell(record: item)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationTitle(Texts.mainTitle)
        } detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $showSheet) {
            addBottomSheet()
        }
    }

    private func addItem() {
        showSheet = true
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
    
    @ViewBuilder private func addBottomSheet() -> some View{
        VStack(alignment: .leading, spacing: 16) {
            AddOptionButton(buttonType: .scan) {
                showSheet = false
                addTestItem()
            }
            
            AddOptionButton(buttonType: .search) {
                showSheet = false
                addTestItem()
            }
            
            AddOptionButton(buttonType: .cancel, separator: false) {
                showSheet = false
            }
        }
        .presentationDetents([.fraction(0.25)])
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
    
    private func addTestItem() {
        withAnimation {
            let newItem = Record(artist: "Artist", album: "Album")
            modelContext.insert(newItem)
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Record.self, inMemory: true)
}
