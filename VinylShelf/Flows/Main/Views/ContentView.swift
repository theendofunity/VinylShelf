//
//  ContentView.swift
//  VinylShelf
//
//  Created by ddudkin on 1. 5. 2026..
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showSheet = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                    } label: {
                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
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
            }
            
            AddOptionButton(buttonType: .search) {
                showSheet = false
            }
            
            AddOptionButton(buttonType: .cancel) {
                showSheet = false
            }
        }
        .presentationDetents([.fraction(0.25)])
        .padding(.top, 24)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
