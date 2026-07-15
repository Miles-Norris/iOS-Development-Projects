//
//  ContentView.swift
//  InterviewProject2
//
//  Created by Miles Norris on 7/14/26.
//

import SwiftUI

struct RandomPeopleView: View {
    let people: [Person]
    
    @State var isSheetPresented = false
    @State var personToPresent: Person? = nil
    var body: some View {
        List {
            ForEach(people, id: \.self) { person in
                Button {
                    personToPresent = person
                    if personToPresent != nil {
                        isSheetPresented = true
                    }
                } label: {
                    HStack {
                        PhotoView(person: person)
                        Text("\(person.name.title) \(person.name.first) \(person.name.last)")
                            .bold()
                            .font(.title3)
                            .padding(.horizontal)
                        Spacer()
                    }
                    .padding(.horizontal)
                }
            }
        }
        .padding(.vertical)
        .listStyle(.inset)
        .navigationTitle("My Random People")
        .sheet(isPresented: $isSheetPresented) {
            if let personToPresent {
                PersonDetailView(person: personToPresent)
            }
        }
    }
    
    struct PhotoView: View {
        let person: Person
        var body: some View {
            let url = person.picture.medium
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(width: 85, height: 85)
                        .scaledToFill()
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
    RandomPeopleView(people: [])
}
