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
        
        // Used to get the size of the device that's currently being used. proxy has properties that we can use to change UI based on the device.
        GeometryReader { proxy in
            
            VStack(alignment: .trailing) {
                
                Button {
                    viewModel.isHistoryShowing.toggle()
                } label: {
                    Circle()
                        .frame(width: viewModel.deviceHeight / 15 - 3)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 4)
                        .overlay {
                            Image(systemName: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                                .resizable()
                                .frame(width: 28, height: 24)
                                .foregroundStyle(Color.black)
                                .scaleEffect(1 + viewModel.deviceWidth * viewModel.deviceWidth / 1200000)
                        }
                        .padding(.trailing, 20)
                        
                }
                
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
                .padding(.horizontal, 15)
                
                // This is a grid of all the buttons on screen. the ForEach goes through all of the buttons in CalculatorButtonData and creates a CalculatorButtonSubview with the parameters given.
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem(), GridItem()], spacing: 7) {
                    ForEach(calculatorButtons) { button in
                        CalculatorButtonSubView(
                            viewModel: $viewModel,
                            buttonClosure: button.buttonClosure,
                            buttonWidth: viewModel.deviceWidth / 4 - 12,
                            buttonHeight: viewModel.deviceHeight / 15 - 3,
                            buttonLabelSize: button.buttonLabelSize + (viewModel.deviceWidth * viewModel.deviceHeight / 150000 - 2),
                            buttonLabel: button.buttonLabel,
                            isSystemImage: button.isSystemImage
                        )
                    }
                }
                .padding(.horizontal, 15)
            }
            .overlay {
                // If the history is onscreen we want to add a dimming effect to the rest of the screen. As well as display the history title.
                if viewModel.isHistoryShowing {
                    ZStack(alignment: .top) {
                        Color.black.opacity(0.35)
                            .ignoresSafeArea()
                            .onTapGesture {
                                viewModel.isHistoryShowing = false
                            }
                        
                        Text("History")
                            .bold()
                            .foregroundStyle(Color.black)
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 35))
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background {
                                Capsule()
                                    .foregroundStyle(Color.white)
                            }
                    }
                }
            }
            .sheet(isPresented: $viewModel.isHistoryShowing) {
                HistoryView(viewModel: $viewModel)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.hidden)
                    .interactiveDismissDisabled(true)
                    .presentationBackgroundInteraction(.enabled)
            }
            .onAppear {
                viewModel.deviceWidth = proxy.size.width
                viewModel.deviceHeight = proxy.size.height
            }
        }
    }
}

#Preview {
    CalculatorView()
}
