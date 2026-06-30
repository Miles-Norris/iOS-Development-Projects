//
//  GamesTrackerApp.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import SwiftUI
import SwiftData

@main
struct GamesTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            GamesView(presenter: GamesPresenter(interactor: GameInteractor(), router: AppRouter.shared))
        }
        .modelContainer(DatabaseManager.shared.container)
    }
}
