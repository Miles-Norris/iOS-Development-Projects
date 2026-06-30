//
//  JournalView.swift
//  SwiftDataJournal
//
//  Created by Miles Norris on 4/28/26.
//

import SwiftUI
import SwiftData

struct JournalView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Journal.createdAt, order: .reverse) private var journals: [Journal]
    
    @State private var newJournalFormDisplayed = false
    @State private var selectedJournal: Journal? = nil
    var body: some View {
        NavigationStack {
            List {
                ForEach(journals) { journal in
                    NavigationLink(destination: EntriesView(journal: journal)) {
                        VStack(alignment: .leading) {
                            Text(journal.title)
                                .bold()
                            
                            Text("Entries: \(String(journal.entryCount))")
                                .font(.system(.subheadline))
                                .foregroundStyle(Color(.secondaryLabel))
                        }
                    }
                }
                .onDelete(perform: { IndexSet in
                    deleteItems(offsets: IndexSet)
                })
            }
            .navigationTitle("Journals")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        newJournalFormDisplayed = true
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $newJournalFormDisplayed) {
                AddJournalView()
                    .presentationDetents([.fraction(0.45)])
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(journals[index])
            }
            try? modelContext.save()
        }
    }
}

#Preview {
    JournalView()
}
