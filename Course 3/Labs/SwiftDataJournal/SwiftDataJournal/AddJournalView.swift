//
//  AddEditJournalView.swift
//  SwiftDataJournal
//
//  Created by Miles Norris on 4/28/26.
//

import SwiftUI
import SwiftData

struct AddJournalView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
   
    @State var title: String = ""
    
    private var saveIsDisabled: Bool {
        title.isEmpty
    }
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
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
                    .padding(.bottom)
                
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
                
                Spacer()
            }
            .padding()
            .navigationTitle("New Journal")
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
        let newJournal = Journal(title: title)
        context.insert(newJournal)
        
        try? context.save()
        dismiss()
    }
}

#Preview {
    AddJournalView()
}
