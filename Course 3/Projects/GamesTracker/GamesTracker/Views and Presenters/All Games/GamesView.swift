//
//  ContentView.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import SwiftUI
import SwiftData

struct GamesView: View {
    @State var presenter: GamesPresenter
    
    var body: some View {
        NavigationStack(path: $presenter.router.navigationPath) {
            List($presenter.games, editActions: .all) { $game in
                    GameSubview(game: game)
                        .onTapGesture {
                            presenter.gamePressed(game: game, gamePresenter: presenter)
                        }
            }
            .navigationTitle("Games")
            .toolbar {
                ToolbarItem{
                    EditButton()
                }
                ToolbarItem {
                    Button {
                        presenter.newGameButtonPressed(gamePresenter: presenter)
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            .navigationDestination(for: AppRouter.AppRoute.self) { route in
                presenter.createView(route: route)
            }
        }
        .onAppear {
            presenter.loadGames()
        }
    }
}

#Preview {
    GamesView(presenter: GamesPresenter(interactor: GameInteractor.shared, router: AppRouter.shared))
}
