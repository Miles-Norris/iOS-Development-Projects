//
//  PlayerInteractor.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI
import SwiftData

class PlayerInteractor: Interactor {
    let context = ModelContext(DatabaseManager.shared.container)
    static let shared = PlayerInteractor()
    
    func addPlayer(name: String, score: Int, game: Game) {
        let newPlayer = Player(name: name, score: score, game: game)
        context.insert(newPlayer)
        save()
    }
    
    func deletePlayers(offsets: IndexSet, players: [Player]) {
        withAnimation {
            for index in offsets {
                context.delete(players[index])
            }
            save()
        }
    }
    
    func save() {
        try? context.save()
    }
}
