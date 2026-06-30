//
//  Player.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftData

@Model
final class Player: Equatable, Comparable {
    var id: String
    var name: String
    var score: Int
    var createdAt: Date
    var game: Game? = nil
    var isAnimated = false
    
    init(name: String, score: Int, game: Game? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.score = score
        self.createdAt = Date()
    }
    
    static func < (lhs: Player, rhs: Player) -> Bool {
        lhs.score < rhs.score
    }
    
    static let dummyPlayer = Player(name: "Jeff", score: 7)
    static let dummyPlayer2 = Player(name: "John", score: 7)
}
