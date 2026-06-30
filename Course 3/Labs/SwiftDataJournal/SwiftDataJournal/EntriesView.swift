//
//  ContentView.swift
//  SwiftDataJournal
//
//  Created by Miles Norris on 4/27/26.
//

import SwiftUI
import SwiftData

struct EntriesView: View {
    let journal: Journal
    
    @Environment(\.modelContext) private var modelContext

    @State private var newEntryFormDisplayed = false
    @State private var selectedEntry: Entry? = nil
    var body: some View {
        NavigationSplitView {
            List {
                ForEach(journal.entries) { entry in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(entry.title)
                                .bold()
                            
                            if let relativeString = relativeDateFormatter.string(for: entry.updatedAt) {
                                Text(relativeString)
                                    .font(.system(.subheadline))
                                    .foregroundStyle(Color(.secondaryLabel))
                            }
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                            .foregroundStyle(Color(.gray))
                    }
                    .onTapGesture {
                        selectedEntry = entry
                    }
                }
                .onDelete(perform: { IndexSet in
                    deleteItems(offsets: IndexSet)
                })
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        newEntryFormDisplayed = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $newEntryFormDisplayed) {
                AddEditEntryView(journal: journal, title: "", bodyString: "")
            }
            .sheet(item: $selectedEntry) { entry in
                AddEditEntryView(entry: entry, journal: journal, title: entry.title, bodyString: entry.body)
            }
            .navigationTitle("My Entries")
            .onChange(of: journal.entries) {
                journal.updatedAt = Date()
            }
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(journal.entries[index])
            }
            try? modelContext.save()
        }
    }
}


