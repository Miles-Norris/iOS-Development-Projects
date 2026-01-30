//
//  CalculatorApp.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import SwiftUI

@main
struct CalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            CalculatorView()
                .preferredColorScheme(.light)
        }
    }
}
