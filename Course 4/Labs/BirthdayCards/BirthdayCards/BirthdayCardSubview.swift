//
//  BirthdayCardSubview.swift
//  BirthdayCards
//
//  Created by Miles Norris on 5/18/26.
//

import SwiftUI

struct BirthdayCardSubview: View {
    let card: BirthdayCard
    var body: some View {
        ZStack {
            Color(card.backgroundColor)
            
            VStack {
                if let image = card.themePhoto {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 115, height: 125)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                
                Text(card.selectedDate.formatted(date: .abbreviated, time: .omitted))
                    .bold()
                    .font(.title3)
                    .padding(.top, 10)
                    .foregroundStyle(.primary)
            }
        }
        .frame(width: 160, height: 220)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    BirthdayCardSubview(card: BirthdayCard(backgroundColor: .blue, selectedDate: Date(), partyDescription: ""))
}
