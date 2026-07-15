//
//  Person.swift
//  InterviewProject1
//
//  Created by Miles Norris on 7/13/26.
//


import Foundation
import SwiftData

@Model
final class Person {
    var id: UUID = UUID()
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}