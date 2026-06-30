//
//  LoginViewModifier.swift
//  Calendar
//
//  Created by Miles Norris on 6/17/26.
//

import Foundation
import SwiftUI

struct LoginButtonStyle: ButtonStyle {
    let isSubmittable: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 325, height: 55)
                    .foregroundStyle(isSubmittable ? .blue : .gray.opacity(0.5))
            }
            .opacity(configuration.isPressed ? 0.5 : 1)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .padding(5)
    }
}

struct LoginTextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .padding(.horizontal, 5)
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.gray.opacity(0.13))
                    .frame(width: 325, height: 55)
            }
            .padding(5)
    }
}

extension View {
    var loginTextFieldStyle: some View {
        self.modifier(LoginTextFieldStyle())
    }
}
