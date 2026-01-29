//
//  AboutView.swift
//  Restaurant
//
//  Created by Miles Norris on 10/9/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        
        ScrollView (showsIndicators: false) {
            VStack (alignment: .leading) {
                Text("About")
                    .font(.largeTitle)
                    .bold()
                
                Image("restaurant-inside")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                
                Text("Sukiyabashi Jiro (すきやばし次郎, Sukiyabashi Jirō) is a sushi restaurant in Ginza, Chūō, Tokyo, owned by Jiro Ono. Ono previously operated as the head chef, but stepped aside in favor of his son Yoshikazu Ono in 2023 due to ill health. Sukiyabashi Jiro was the first sushi restaurant to receive three stars from the Michelin Guide. It was removed from the Michelin Guide in November 2019 as it does not receive reservations from the general public, instead requiring reservations to be made through the concierge of a luxury hotel.")
                
                Image("map")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.bottom)
                
                Text("""
    Tsukamoto Sogyo Building
    Basement Floor 1
    2-15, Ginza 4-chome
    Chūō, Tokyo
    """)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AboutView()
}
