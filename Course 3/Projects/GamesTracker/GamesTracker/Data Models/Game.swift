//
//  Game.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftData

@Model
final class Game {
    var id: String
    var name: String
    var createdAt: Date
    var sortByLowestScore: Bool
    @Relationship(deleteRule: .cascade, inverse: \Player.game) var players: [Player]
    var isGameOver: Bool
    var imageURL: String? = nil
    var sortedPlayers: [Player] {
        if sortByLowestScore {
            players.sorted(by: <)
        } else {
            players.sorted(by: >)
        }
    }
    
    var winningPlayer: Player? {
        if let player = sortedPlayers.first {
            return player
        } else { return nil }
    }
    
    init(name: String, sortByLowestScore: Bool, players: [Player], isGameOver: Bool, imageURL: String? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.createdAt = Date()
        self.sortByLowestScore = sortByLowestScore
        self.players = players
        self.isGameOver = isGameOver
        self.imageURL = imageURL
    }
    
    static let dummyGame = Game(name: "Fortnite", sortByLowestScore: false, players: [Player.dummyPlayer, Player.dummyPlayer2], isGameOver: false, imageURL: "https://images.igdb.com/igdb/image/upload/t_cover_big/cobssb.webp")
    static let dummyGame2 = Game(name: "Smash Bros.", sortByLowestScore: false, players: [Player.dummyPlayer, Player.dummyPlayer2], isGameOver: false, imageURL: "https://www.gamespot.com/a/uploads/scale_landscape/3/37852/4594000-header.jpg")
}


