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
    @Binding var deviceWidth: CGFloat
    @Binding var deviceHeight: CGFloat
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.operationHistory, id: \.self) { operation in
                    RoundedRectangle(cornerRadius: 20)
                        .frame(width: deviceWidth - (deviceWidth / 10), height: deviceHeight / 10)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 7)
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
        }
        .scrollBounceBehavior(.basedOnSize)
        .defaultScrollAnchor(.bottom)
    }
}

#Preview {
    @Previewable @State var viewModel = CalculatorViewModel()
    @Previewable @State var deviceWidth: CGFloat = 402
    @Previewable @State var deviceHeight: CGFloat = 778
    HistoryView(viewModel: $viewModel, deviceWidth: $deviceWidth, deviceHeight: $deviceHeight)
}
