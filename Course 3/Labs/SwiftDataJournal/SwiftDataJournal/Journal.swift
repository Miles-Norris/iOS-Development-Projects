//
//  Journal.swift
//  SwiftDataJournal
//
//  Created by Miles Norris on 4/28/26.
//

import Foundation
import SwiftData

@Model
final class Journal {
    var id: String
    var title: String
    var createdAt: Date
    var updatedAt: Date
    @Relationship(deleteRule: .cascade, inverse: \Entry.journal) var entries: [Entry] = []
    var entryCount: Int {
        entries.count
    }
    
    init(title: String) {
        self.id = UUID().uuidString
        self.title = title
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
