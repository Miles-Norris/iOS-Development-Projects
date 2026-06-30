//
//  NewPlayerPresenter.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class NewPlayerPresenter: Presenter {
    var interactor: PlayerInteractor
    var router: AppRouter
    
    var game: Game
    
    var playerName = ""
    var playerScore = 0
    
    init(interactor: PlayerInteractor, router: AppRouter, game: Game) {
        self.interactor = interactor
        self.router = router
        self.game = game
    }
    
    func savePlayer() {
        game.players.append(Player(name: playerName, score: playerScore))
    }
}
