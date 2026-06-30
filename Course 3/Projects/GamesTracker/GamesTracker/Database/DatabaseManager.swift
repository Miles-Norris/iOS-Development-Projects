//
//  DatabaseManager.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftData

class DatabaseManager {
    static let shared = DatabaseManager()
    let container: ModelContainer

    init() {
        do {
            let schema = Schema([Game.self, Player.self])
            let config = ModelConfiguration(isStoredInMemoryOnly: false)
            container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
}
