//
//  AddEditEntryView.swift
//  SwiftDataJournal
//
//  Created by Miles Norris on 4/27/26.
//

import SwiftUI
import SwiftData

struct AddEditEntryView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    var entry: Entry?
    let journal: Journal
    
    @State var title: String
    @State var bodyString: String
    
    private var saveIsDisabled: Bool {
        title.isEmpty || bodyString.isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                
                TextField("Title", text: $title)
                    .frame(width: 335, height: 35)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background {
                        Capsule()
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                    }
                    .glassEffect()
                
                TextEditor(text: $bodyString)
                    .frame(width: 345, height: 450)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
                    .background {
                        RoundedRectangle(cornerRadius: 30)
                            .foregroundStyle(.white)
                            .shadow(radius: 5)
                    }
                    .glassEffect()
                
                Button {
                    save()
                } label: {
                    Capsule()
                        .frame(width: 200, height: 55)
                        .shadow(radius: 5)
                        .overlay {
                            Text("Save")
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                                .bold()
                        }
                        .glassEffect()
                }
                .disabled(saveIsDisabled)
            }
            .padding()
            .navigationTitle(entry == nil ? "New Entry" : entry!.title)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Cancel", systemImage: "multiply")
                            .glassEffect()
                            .padding()
                    }
                }
            }
        }
    }
    
    private func save() {
        if let entry {
            entry.title = title
            entry.body = bodyString
            entry.updatedAt = Date()

            try? context.save()
        } else {
            let newEntry = Entry(title: title, body: bodyString, journal: journal)
            context.insert(newEntry)
            
            try? context.save()
        }
        dismiss()
    }
}

