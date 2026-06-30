//
//  NewPlayerView.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/6/26.
//

import SwiftUI

struct NewPlayerView: View {
    @Environment(\.dismiss) var dismiss
    @State var presenter: NewPlayerPresenter
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 50) {
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 200))
                    .padding(.top, 50)
                
                TextField("Name", text: $presenter.playerName)
                    .textFieldStyle(.roundedBorder)
                    .font(.system(size: 30))
                    .padding(.horizontal, 50)
                    .padding(.vertical)
                    .bold()
                
                Stepper("Initial Score: \(presenter.playerScore)", value: $presenter.playerScore, in: 0...999)
                    .font(.system(size: 20))
                    .padding(.horizontal, 50)
                    .bold()
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "multiply")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        presenter.savePlayer()
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    NewPlayerView(presenter: NewPlayerPresenter(interactor: PlayerInteractor.shared, router: AppRouter.shared, game: Game.dummyGame))
}
