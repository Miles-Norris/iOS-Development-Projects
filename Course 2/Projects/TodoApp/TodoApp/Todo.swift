//
//  Todo.swift
//  TodoApp
//
//  Created by Miles Norris on 3/4/26.
//

import Foundation

struct Todo: Identifiable {
    var id: UUID = UUID()
    var markedComplete: Bool
    var title: String
}

struct TodoSection: Identifiable {
    var id = UUID()
    var sectionTitle: String
    var todos: [Todo]
}

extension TodoSection {
    static var dummySections: [TodoSection] = [
        TodoSection(sectionTitle: "School", todos: [
            Todo(markedComplete: false, title: "Buy groceries"),
            Todo(markedComplete: false, title: "Walk the dog"),
            Todo(markedComplete: false, title: "Read 20 pages of a book"),
            Todo(markedComplete: false, title: "Finish the quarterly report")]),
        TodoSection(sectionTitle: "Home", todos: [
            Todo(markedComplete: false, title: "Call the dentist to schedule appointment"),
            Todo(markedComplete: false, title: "Pay electricity bill"),
            Todo(markedComplete: false, title: "Plan weekend trip itinerary"),
            Todo(markedComplete: false, title: "Clean the kitchen"),
            Todo(markedComplete: false, title: "Reply to emails"),
            Todo(markedComplete: false, title: "Exercise for 30 minutes")])
    ]
}
