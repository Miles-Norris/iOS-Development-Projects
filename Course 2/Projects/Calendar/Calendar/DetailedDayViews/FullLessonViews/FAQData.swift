//
//  FAQData.swift
//  Calendar
//
//  Created by Miles Norris on 6/10/26.
//

import Foundation

struct FAQ: Codable, Identifiable, Equatable {
    var id: UUID
    var assignmentID: UUID
    var lessonID: UUID
    var question: String
    var answer: String
    var lastEditedOn: String
    var lastEditedBy: String
}
