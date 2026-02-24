//
//  MyModifier.swift
//  ViewModifierExamples
//
//  Created by Toby Youngberg on 9/15/25.
//

import SwiftUI

struct MyModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .padding(5)
            .underline()
            .foregroundStyle(Color.teal)
            .frame(width: 200, height: 200)
            .background(Color.blue)
            .border(.black, width: 5)
    }
}

extension View {
    func myModifier() -> some View {
        modifier(MyModifier())
    }
}
