//
//  CalculatorButtonData.swift
//  Calculator
//
//  Created by Miles Norris on 2/27/26.
//

import Foundation


extension CalculatorViewModel {
    
    struct CalculatorButtons: Identifiable {
        let id: UUID = UUID()
        let buttonClosure: (String) -> Void
        let buttonLabelSize: CGFloat
        let buttonLabel: String
        let isSystemImage: Bool
        
        init(buttonClosure: @escaping (String) -> Void,
             buttonLabelSize: CGFloat, buttonLabel: String,
             isSystemImage: Bool) {
            self.buttonClosure = buttonClosure
            self.buttonLabelSize = buttonLabelSize
            self.buttonLabel = buttonLabel
            self.isSystemImage = isSystemImage
        }
        init(buttonClosure: @escaping () -> Void,
            buttonLabelSize: CGFloat,
            buttonLabel: String,
            isSystemImage: Bool) {
            self.buttonClosure = { _ in
                buttonClosure()
            }
            self.buttonLabelSize = buttonLabelSize
            self.buttonLabel = buttonLabel
            self.isSystemImage = isSystemImage
        }
    }

    var calculatorButtons: [CalculatorButtons] { [
        CalculatorButtons(
            buttonClosure: exponentButton,
            buttonLabelSize: 22,
            buttonLabel: "^",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: sqrtButton,
            buttonLabelSize: 21,
            buttonLabel: "√",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: openParenButton,
            buttonLabelSize: 21,
            buttonLabel: "(",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: closeParenButton,
            buttonLabelSize: 21,
            buttonLabel: ")",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: memoryAddButton,
            buttonLabelSize: 18,
            buttonLabel: "M+",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: memorySubtractButton,
            buttonLabelSize: 18,
            buttonLabel: "M-",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: memoryRecallButton,
            buttonLabelSize: 18,
            buttonLabel: "MR",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: memoryClearButton,
            buttonLabelSize: 18,
            buttonLabel: "MC",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: backspaceButton,
            buttonLabelSize: 18,
            buttonLabel: "delete.left",
            isSystemImage: true),
        CalculatorButtons(
            buttonClosure: allClear,
            buttonLabelSize: 18,
            buttonLabel: "AC",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: percentageButton,
            buttonLabelSize: 22,
            buttonLabel: "%",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: divisionButton,
            buttonLabelSize: 18,
            buttonLabel: "divide",
            isSystemImage: true),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "7",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "8",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "9",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: mulitplicationButton,
            buttonLabelSize: 18,
            buttonLabel: "multiply",
            isSystemImage: true),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "4",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "5",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "6",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: subtractionButton,
            buttonLabelSize: 17,
            buttonLabel: "minus",
            isSystemImage: true),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "1",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "2",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: positiveNumberButton(_:),
            buttonLabelSize: 21,
            buttonLabel: "3",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: additionButton,
            buttonLabelSize: 17,
            buttonLabel: "plus",
            isSystemImage: true),
        CalculatorButtons(
            buttonClosure: signChangeButton,
            buttonLabelSize: 18,
            buttonLabel: "plus.forwardslash.minus",
            isSystemImage: true),
        CalculatorButtons(
            buttonClosure: zeroButton,
            buttonLabelSize: 21,
            buttonLabel: "0",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: decimalButton,
            buttonLabelSize: 21,
            buttonLabel: ".",
            isSystemImage: false),
        CalculatorButtons(
            buttonClosure: equalsButton,
            buttonLabelSize: 18,
            buttonLabel: "equal",
            isSystemImage: true),
    ]
    }
}
