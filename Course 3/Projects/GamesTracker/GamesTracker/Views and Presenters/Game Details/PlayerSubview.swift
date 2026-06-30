//
//  PlayerSubview.swift
//  GamesTracker
//
//  Created by Miles Norris on 5/8/26.
//

import SwiftUI

struct PlayerSubview: View {
    let player: Player
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .font(.system(size: 55))
            
            Text(player.name)
                .font(.title)
                .bold()
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .padding(10)
        }
    }
}

#Preview {
    PlayerSubview(player: Player.dummyPlayer)
}
