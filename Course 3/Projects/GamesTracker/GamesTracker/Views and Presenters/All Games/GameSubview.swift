//
//  GameSubview.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/7/26.
//

import SwiftUI

struct GameSubview: View {
    let game: Game
    
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 85, height: 85)
                .foregroundStyle(.white)
                .shadow(radius: 8)
                .overlay {
                    PhotoView(game: game)
                }
                .padding(.trailing)
                .padding(.leading, 5)
            
            VStack {
                Text(game.name)
                    .font(.title2)
                    .bold()
                
                Divider()
                    .frame(width: 160)
                    .padding(.bottom, 5)
                    .padding(.top, 0)
                
                if let winningPlayer = game.winningPlayer {
                    if game.isGameOver {
                        Text("\(winningPlayer.name) Won!")
                            .font(.caption)
                            .bold()
                    } else {
                        Text("\(winningPlayer.name) is Winning!")
                            .font(.subheadline)
                            .bold()
                    }
                }
            }
            .padding(.trailing, 20)
        }
    }
    
    struct PhotoView: View {
        let game: Game
        var body: some View {
            if let urlString = game.imageURL, let url = URL(string: urlString) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .frame(width: 85, height: 85)
                            .scaledToFill()
                    case .failure:
                        Image(systemName: "dice.fill")
                            .font(.system(size: 65))
                    @unknown default:
                        fatalError()
                    }
                }
            } else {
                Image(systemName: "dice.fill")
                    .font(.system(size: 65))
            }
        }
    }
}

#Preview {
    GameSubview(game: Game.dummyGame)
}
