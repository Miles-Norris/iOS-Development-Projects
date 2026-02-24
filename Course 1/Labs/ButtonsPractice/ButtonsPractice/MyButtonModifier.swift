//
//  MyButtonModifier.swift
//  ButtonsPractice
//
//  Created by Miles Norris on 2/23/26.
//

import SwiftUI

struct MyButtonModifier: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 60)
            .foregroundStyle(Color.blue)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.red)
                    .frame(width: 300, height: 80)
            )
            .scaleEffect(configuration.isPressed ? 0.85 : 1.0)
            .animation(.bouncy, value: configuration.isPressed)
    }
}
