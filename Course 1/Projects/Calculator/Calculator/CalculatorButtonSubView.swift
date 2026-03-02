//
//  CalculatorButtonSubView.swift
//  Calculator
//
//  Created by Miles Norris on 2/27/26.
//

import SwiftUI

struct CalculatorButtonSubView: View {
    
    @Binding var viewModel: CalculatorViewModel
    
    let buttonClosure: (String) -> Void
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    let buttonLabelSize: CGFloat
    let buttonLabel: String
    let isSystemImage: Bool
    
    init(viewModel: Binding<CalculatorViewModel>,
         buttonClosure: @escaping (String) -> Void,
         buttonWidth: CGFloat,
         buttonHeight: CGFloat,
         buttonLabelSize: CGFloat,
         buttonLabel: String,
         isSystemImage: Bool) {
        self._viewModel = viewModel
        self.buttonClosure = buttonClosure
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.buttonLabelSize = buttonLabelSize
        self.buttonLabel = buttonLabel
        self.isSystemImage = isSystemImage
    }
    init(viewModal: Binding<CalculatorViewModel>,
         buttonClosure: @escaping () -> Void,
         buttonWidth: CGFloat,
         buttonHeight: CGFloat,
         buttonLabelSize: CGFloat,
         buttonLabel: String,
         isSystemImage: Bool) {
        self._viewModel = viewModal
        self.buttonClosure = { _ in
            buttonClosure()
        }
        self.buttonWidth = buttonWidth
        self.buttonHeight = buttonHeight
        self.buttonLabelSize = buttonLabelSize
        self.buttonLabel = buttonLabel
        self.isSystemImage = isSystemImage
    }
    
    var safeButtonWidth: CGFloat {
        let width = buttonWidth
        if !width.isFinite || width <= 0 {
            return 1
        }
        return width
    }

    var safeButtonHeight: CGFloat {
        let height = buttonHeight
        if !height.isFinite || height <= 0 {
            return 1
        }
        return height
    }
    
    var body: some View {
        Button {
            buttonClosure(buttonLabel)
        } label: {
            RoundedRectangle(cornerRadius: 20)
                .frame(width: safeButtonWidth, height: safeButtonHeight)
                .foregroundStyle(Color(buttonLabel == "MR" ? viewModel.mrButtonColor : .white))
                .shadow(radius: 4)
                .overlay {
                    if isSystemImage {
                        Image(systemName: buttonLabel)
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: buttonLabelSize))
                    } else {
                        Text(buttonLabel)
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: buttonLabelSize))
                            .bold()
                            .foregroundStyle(Color(.black))
                    }
                }
        }
    }
}
