//
//  ContentView.swift
//  InterviewProject1
//
//  Created by Miles Norris on 7/13/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var savedPeople: [Person]
    @State var isNewPersonSheetDisplayed = false
    @State var unsavedPeople: [Person] = []

    var body: some View {
        NavigationSplitView {
            VStack {
                List {
                    if !savedPeople.isEmpty {
                        Section {
                            ForEach(savedPeople) { person in
                                Text(person.name)
                            }
                            .onDelete(perform: deleteSavedPerson)
                        } header: {
                            Text("Saved People")
                        }
                    }
                    
                    if !unsavedPeople.isEmpty {
                        Section {
                            ForEach(unsavedPeople) { person in
                                Text(person.name)
                            }
                            .onDelete(perform: deleteUnsavedPerson)
                        } header: {
                            Text("New People")
                        }
                    }
                }
                .navigationTitle("My People")
                .listStyle(.insetGrouped)
                .sheet(isPresented: $isNewPersonSheetDisplayed) {
                    NewPersonView(unsavedPeople: $unsavedPeople)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                            .disabled(savedPeople.isEmpty && unsavedPeople.isEmpty)
                    }
                    ToolbarItem {
                        Button {
                            isNewPersonSheetDisplayed = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
                
                Button {
                    saveRandomPerson()
                } label: {
                    Text("Select Random")
                        .bold()
                }
                .buttonStyle(.glassProminent)
                .disabled(unsavedPeople.isEmpty)
            }
            .background {
                if !unsavedPeople.isEmpty || !savedPeople.isEmpty {
                    Color(.systemGroupedBackground)
                        .ignoresSafeArea()
                }
            }
            
        } detail: {
            Text("Select an item")
        }
    }

    private func deleteSavedPerson(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(savedPeople[index])
            }
        }
    }
    
    private func deleteUnsavedPerson(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                unsavedPeople.remove(at: index)
            }
        }
    }
    
    private func saveRandomPerson() {
        withAnimation {
            let randomLocation = Int.random(in: 0...unsavedPeople.count - 1)
            let randomPerson = unsavedPeople.remove(at: randomLocation)
            
            modelContext.insert(randomPerson)
            
            try? modelContext.save()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Person.self, inMemory: true)
}
