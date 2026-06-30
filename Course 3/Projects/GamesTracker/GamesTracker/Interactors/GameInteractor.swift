//
//  GameInteractor.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI
import SwiftData

class GameInteractor: Interactor {
    let context: ModelContext = ModelContext(DatabaseManager.shared.container)
    static let shared = GameInteractor()
    
    func addGame(game: Game) {
        context.insert(game)
        try? context.save()
    }
    
    func deleteGames(offsets: IndexSet, games: [Game]) {
        withAnimation {
            for index in offsets {
                context.delete(games[index])
            }
            try? context.save()
        }
    }
    
    func save() {
        try? context.save()
    }
    
    func loadGames() -> [Game] {
        let descriptor = FetchDescriptor<Game>(
            predicate: #Predicate { !$0.name.isEmpty },
            sortBy: [SortDescriptor(\.createdAt)]
        )
        
        do {
            return try context.fetch(descriptor)
        } catch {
            print("Fetch failed: \(error)")
            return []
        }
    }
}
