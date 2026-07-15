//
//  PersonDetailView.swift
//  InterviewProject2
//
//  Created by Miles Norris on 7/14/26.
//

import SwiftUI

struct PersonDetailView: View {
    @Environment(\.dismiss) var dismiss
    let person: Person
    var body: some View {
        NavigationStack {
            VStack {
                PhotoView(person: person)
                    .padding(.top, 20)
                
                Text("\(person.name.title) \(person.name.first) \(person.name.last)")
                    .bold()
                    .font(.largeTitle)
                    .padding()
                
                List {
                    Text("Age: \(person.dob.age)")
                        .bold()
                    Text("Phone: \(person.phone)")
                        .bold()
                    Text("Email: \(person.email)")
                        .bold()
                    Text("Address: \(String(person.location.street.number).filter { $0.isNumber }) \(person.location.street.name) Street, \(person.location.city), \(person.location.state), \(person.location.country)")
                        .bold()
                }
                .listStyle(.insetGrouped)
            }
            .background {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
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
    
    struct PhotoView: View {
        let person: Person
        var body: some View {
            let url = person.picture.large
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 150, height: 150)
                        .scaledToFill()
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 5)
                                .frame(width: 150)
                        }
                case .failure:
                    Image(systemName: "person")
                        .font(.system(size: 65))
                @unknown default:
                    fatalError()
                }
            }
        }
    }
}

#Preview {
    PersonDetailView(person: Person.dummyPerson)
}
