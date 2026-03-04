//
//  ContentView.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import SwiftUI

struct CalculatorView: View {
    
    // This is the view model that holds all the methods and properties for the view.
    @State var viewModel = CalculatorViewModel()
    
    var body: some View {
        
        GeometryReader { proxy in
            let isPortrait = proxy.size.height >= proxy.size.width
            
            VStack {
                Spacer()
                // This HStack hold the main text of the calculator
                HStack {
                    Spacer()
                    Text(viewModel.currentOperationText)
                        .bold()
                        .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 75))
                        .padding(.horizontal, 18)
                        .lineLimit(1)
                        .truncationMode(.head)
                        .minimumScaleFactor(0.4)
                }
                
                // This is a grid of all the buttons on screen. the ForEach goes through all of the buttons in CalculatorButtonData and creates a CalculatorButtonSubview with the parameters given.
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 7) {
                    ForEach(calculatorButtons) { button in
                        CalculatorButtonSubView(
                            viewModel: $viewModel,
                            buttonClosure: button.buttonClosure,
                            buttonWidth: isPortrait ? proxy.size.width / 4 - 12 : proxy.size.width / 4 - 75,
                            buttonHeight: isPortrait ? proxy.size.height / 15 - 3 : proxy.size.height / 11,
                            buttonLabelSize: button.buttonLabelSize,
                            buttonLabel: button.buttonLabel,
                            isSystemImage: button.isSystemImage
                        )
                    }
                }
            }
            .padding(.horizontal, isPortrait ? 15 : 140)
        }
    }
}

#Preview {
    CalculatorView()
}
