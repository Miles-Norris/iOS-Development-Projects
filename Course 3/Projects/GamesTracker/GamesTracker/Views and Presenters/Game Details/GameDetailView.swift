//
//  GameDetailView.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import SwiftUI

struct GameDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var presenter: GameDetailPresenter
    
    var body: some View {
        VStack {
            List($presenter.game.players, editActions: .delete) { $player in
                HStack {
                    PlayerSubview(player: player)
                    
                    Spacer()
                    
                    VStack {
                        Text("Score: \(player.score)")
                            .font(.system(size: player.isAnimated ? 23 : 22))
                            .bold()
                        
                        Stepper("", value: $player.score, in: 0...999)
                            .labelsHidden()
                            .frame(width: 10, height: 25)
                    }
                    .padding(.horizontal, 30)
                }
                .onChange(of: player.score) {
                    withAnimation(.easeInOut(duration: 0.05)) {
                        player.isAnimated = true
                    } completion: {
                        withAnimation(.easeInOut(duration: 0.05)) {
                            player.isAnimated = false
                        }
                    }
                    presenter.sortPlayers()
                }
            }
            
            Button {
                presenter.finishGamePressed()
                dismiss()
            } label: {
                Text(presenter.game.isGameOver ? "Continue Game" : "Finish Game")
            }
            .buttonStyle(.borderedProminent)
        }
        .background {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        }
        .toolbar {
            ToolbarItem {
                EditButton()
            }
            ToolbarItem {
                Button {
                    presenter.settingsButtonPressed()
                } label: {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
        .navigationTitle(presenter.game.name)
        .onChange(of: presenter.game.players) {
            presenter.sortPlayers()
        }
    }
}

#Preview {
    GameDetailView(presenter: GameDetailPresenter(interactor: GameInteractor.shared, router: AppRouter.shared, gamePresenter: GamesPresenter(interactor: GameInteractor.shared, router: AppRouter.shared), game: Game.dummyGame))
}
