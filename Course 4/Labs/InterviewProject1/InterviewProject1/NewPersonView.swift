//
//  NewPersonView.swift
//  InterviewProject1
//
//  Created by Miles Norris on 7/13/26.
//

import SwiftUI
import SwiftData

struct NewPersonView: View {
    @Environment(\.dismiss) var dismiss
    @State var name: String = ""
    @Binding var unsavedPeople: [Person]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Text("Add A New Person")
                    .bold()
                    .font(.largeTitle)
                
                TextField("Name", text: $name)
                    .padding()
                    .background {
                        Capsule()
                            .stroke(lineWidth: 1)
                    }
                    .padding(35)
                
                Button {
                    addPerson(name: name)
                    dismiss()
                } label: {
                    Text("Save")
                        .bold()
                }
                .buttonStyle(.glassProminent)
                .disabled(name.isEmpty)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                    }
                }
            }
        }
    }
    
    private func addPerson(name: String) {
        withAnimation {
            let newPerson = Person(name: name)
            unsavedPeople.append(newPerson)
        }
    }
}
