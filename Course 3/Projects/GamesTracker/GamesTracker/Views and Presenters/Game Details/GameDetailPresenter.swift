//
//  GameDetailPresenter.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class GameDetailPresenter: Presenter {
    var interactor: GameInteractor
    var router: AppRouter
    var gamePresenter: GamesPresenter
    
    var game: Game
    
    init(interactor: GameInteractor, router: AppRouter, gamePresenter: GamesPresenter, game: Game) {
        self.interactor = interactor
        self.router = router
        self.gamePresenter = gamePresenter
        self.game = game
    }
    
    func settingsButtonPressed() {
        router.navigate(to: .newGame(game: game, gamePresenter: gamePresenter))
    }
    
    func sortPlayers() {
        game.players = game.sortedPlayers
    }
    
    func finishGamePressed() {
        game.isGameOver.toggle()
    }
    
}
