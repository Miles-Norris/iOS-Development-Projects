//
//  AppRouter.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI

@Observable
class AppRouter {
    static let shared = AppRouter()
    
    var navigationPath = NavigationPath()
   
    enum AppRoute: Hashable {
        case allGames
        case newGame(game: Game? = nil, gamePresenter: GamesPresenter)
        case gameDetails(game: Game, gamePresenter: GamesPresenter)
        case newPlayer(game: Game)
    }
    
    @ViewBuilder
    func view(for route: AppRoute) -> some View {
        switch route {
        case .allGames:
            GamesView(presenter: GamesPresenter(interactor: GameInteractor.shared, router: AppRouter.shared))
        case .newGame(let game, let gamePresenter):
            AddEditGameView(presenter: AddEditGamePresenter(interactor: GameInteractor.shared, router: AppRouter.shared, gamePresenter: gamePresenter, game: game))
        case .gameDetails(let game, let gamePresenter):
            GameDetailView(presenter: GameDetailPresenter(interactor: GameInteractor.shared, router: AppRouter.shared, gamePresenter: gamePresenter, game: game))
        case .newPlayer(let game):
            NewPlayerView(presenter: NewPlayerPresenter(interactor: PlayerInteractor.shared, router: AppRouter.shared, game: game))
        }
    }
    
    func navigate(to route: AppRoute) {
        navigationPath.append(route)
    }
    
    func popToRoot() {
        navigationPath = NavigationPath()
    }
}
