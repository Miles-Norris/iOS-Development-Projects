//
//  HistoryView.swift
//  Calculator
//
//  Created by Miles Norris on 3/5/26.
//

import SwiftUI

struct HistoryView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var viewModel: CalculatorViewModel
    
    var body: some View {
        GeometryReader { proxy in
            let modalWidth = proxy.size.width
            let modalHeight = proxy.size.height
            
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(viewModel.operationHistory, id: \.self) { operation in
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: modalWidth - 30, height: modalHeight / 5 - 10)
                            .foregroundStyle(Color.white)
                            .shadow(radius: 10)
                            .overlay {
                                Text(operation)
                                    .bold()
                                    .foregroundStyle(Color.black)
                                    .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 75))
                                    .padding(.horizontal, 18)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.4)
                            }
                            .onTapGesture {
                                viewModel.recallHistory(operation)
                                dismiss()
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
                .padding(.bottom, 5)
            }
            .scrollBounceBehavior(.basedOnSize)
            .defaultScrollAnchor(.bottom)
        }
    }
}

#Preview {
    @Previewable @State var viewModel = CalculatorViewModel()
    HistoryView(viewModel: $viewModel)
}
