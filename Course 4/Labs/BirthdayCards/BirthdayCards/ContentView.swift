//
//  ContentView.swift
//  BirthdayCards
//
//  Created by Miles Norris on 5/18/26.
//

import SwiftUI
import Photos

struct ContentView: View {
    @State var isNewCardViewPresented = false
    @State var cards: [BirthdayCard] = []
    var body: some View {
        NavigationStack {
            VStack {
                LazyVGrid(columns: [GridItem(), GridItem()]) {
                    ForEach(cards) { card in
                        NavigationLink(destination: CardDetailView(card: card)) {
                            BirthdayCardSubview(card: card)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(25)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem {
                    Button {
                        isNewCardViewPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isNewCardViewPresented) {
                NewCardView(cards: $cards)
            }
            .navigationTitle("Birthday Cards")
        }
    }
}

#Preview {
    ContentView()
}
