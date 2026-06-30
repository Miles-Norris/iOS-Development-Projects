//
//  GamesPresenter.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class GamesPresenter: Presenter, Equatable, Hashable {
    var interactor: GameInteractor
    var router: AppRouter
    
    var games: [Game] = [Game.dummyGame, Game.dummyGame2]
    
    init(interactor: GameInteractor, router: AppRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func newGameButtonPressed(gamePresenter: GamesPresenter) {
        router.navigate(to: .newGame(game: nil, gamePresenter: gamePresenter))
    }
    
    func gamePressed(game: Game, gamePresenter: GamesPresenter) {
        router.navigate(to: .gameDetails(game: game, gamePresenter: gamePresenter))
    }
    
    func loadGames() {
        games = interactor.loadGames()
        if games.isEmpty {
            games = [Game.dummyGame, Game.dummyGame2]
        }
    }
    
    func createView(route: AppRouter.AppRoute) -> some View {
        router.view(for: route)
    }
    
    static func == (lhs: GamesPresenter, rhs: GamesPresenter) -> Bool {
        lhs.games == rhs.games
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(games)
    }
}
