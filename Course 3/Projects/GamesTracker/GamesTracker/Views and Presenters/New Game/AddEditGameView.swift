//
//  NewGameView.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import SwiftUI

struct AddEditGameView: View {
    @Environment(\.dismiss) var dismiss
    @State var presenter: AddEditGamePresenter
    
    var body: some View {
        VStack(alignment: .center) {
            
            GameConfigsView(presenter: $presenter)
            
            Text("Players")
                .font(.headline)
                .padding(.top, 50)
            
            Divider()
                .padding(.bottom, 10)

            List(presenter.getBindings(), editActions: .delete) { $player in
                PlayerSubview(player: player)
            }
            .listStyle(.inset)
            
            Button {
                presenter.saveButtonPressed()
                dismiss()
            } label: {
                Text("Save")
                    .font(.system(size: 20))
                    .bold()
            }
            .buttonStyle(.borderedProminent)
            .disabled((presenter.players.isEmpty && presenter.game == nil) || presenter.gameName.isEmpty)
            
        }
        .padding()
        .sheet(isPresented: $presenter.isNewPlayerPresented) {
            presenter.getSheetView()
        }
        .toolbar {
            ToolbarItem {
                EditButton()
            }
            ToolbarItem {
                Button("Add Player") {
                    presenter.addPlayerPressed()
                }
            }
        }
        .onAppear {
            presenter.loadGame()
        }
    }
    
    struct GameConfigsView: View {
        @Binding var presenter: AddEditGamePresenter
        var body: some View {
            TextField("Game Name", text: $presenter.gameName)
                .font(.title2)
                .bold()
                .padding(.bottom)
            
            Text("Game Photo")
                .font(.headline)
            
            Divider()
                .padding(.bottom, 10)
            
            TextField("Photo Link", text: $presenter.imageURL)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom, 25)
            
            Text("Winning Score")
                .font(.headline)
            
            Divider()
                .padding(.bottom, 10)
            
            Picker("", selection: $presenter.sortByLowestScore) {
                Text("Highest").tag(false)
                Text("Lowest").tag(true)
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    AddEditGameView(presenter: AddEditGamePresenter(interactor: GameInteractor.shared, router: AppRouter.shared, gamePresenter: GamesPresenter(interactor: GameInteractor.shared, router: AppRouter.shared)))
}
