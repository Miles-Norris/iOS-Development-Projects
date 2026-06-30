//
//  NewGamePresenter.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
class AddEditGamePresenter: Presenter {
    var interactor: GameInteractor
    var router: AppRouter
    var gamePresenter: GamesPresenter
    
    var game: Game?
    var sortByLowestScore = false
    var players: [Player] = []
    var gameName: String = ""
    var imageURL: String = ""
    var isNewPlayerPresented = false
    var newGameCreated = false
   
    init(interactor: GameInteractor, router: AppRouter, gamePresenter: GamesPresenter, game: Game? = nil) {
        self.interactor = interactor
        self.router = router
        self.gamePresenter = gamePresenter
        self.game = game
    }
    
    func loadGame() {
        if let game {
            gameName = game.name
            if let url = game.imageURL {
                imageURL = url
            }
        }
    }
    
    func saveButtonPressed() {
        if game != nil {
            game?.sortByLowestScore = sortByLowestScore
            game?.name = gameName
            game?.imageURL = imageURL
            if newGameCreated {
                interactor.addGame(game: game!)
            } else {
                interactor.save()
            }
        } else {
            game = Game(name: gameName, sortByLowestScore: sortByLowestScore, players: players, isGameOver: false, imageURL: imageURL)
            interactor.addGame(game: game!)
            interactor.save()
        }
        loadGames()
    }
    
    func addPlayerPressed() {
        isNewPlayerPresented = true
    }
    
    func getBindings() -> Binding<[Player]> {
        if game != nil {
            return Binding<[Player]>(
                get: { self.game?.players ?? [] },
                set: { newValue in
                    if self.game != nil {
                        self.game!.players = newValue
                    }
                }
            )
        } else {
            return Binding<[Player]>(
                get: { self.players },
                set: { self.players = $0 }
            )
        }
    }
    
    func getSheetView() -> some View {
        if let game {
            return router.view(for: .newPlayer(game: game))
        } else {
            newGameCreated = true
            game = Game(name: gameName, sortByLowestScore: sortByLowestScore, players: players, isGameOver: false, imageURL: imageURL)
            return router.view(for: .newPlayer(game: self.game!))
        }
    }
    
    func loadGames() {
        gamePresenter.loadGames()
    }
}
