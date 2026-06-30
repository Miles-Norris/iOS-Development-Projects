//
//  Person.swift
//  GeometryReaderLab
//
//  Created by Miles Norris on 5/13/26.
//

import Foundation

struct Person: Identifiable {
    var id: UUID = UUID()
    var name: String
    var description: String
    
    static let people: [Person] = [
        Person(name: "Bob", description: "Chef"),
        Person(name: "Phil", description: "Dad"),
        Person(name: "Mary", description: "Teacher"),
        Person(name: "Anne", description: "Writer"),
        Person(name: "David", description: "Actor"),
        Person(name: "Joe", description: "Doctor"),
        Person(name: "June", description: "Vet"),
        Person(name: "Beth", description: "Lawyer"),
//        Person(name: "George", description: "Mechanic")
    ]
}
