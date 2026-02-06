//
//  ContentView.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import SwiftUI

//Extension of type Double to check if a Double is a round double (eg: 78.0 vs 78.1).
extension Double {
    var isRound: Bool {
        return self.truncatingRemainder(dividingBy: 1) == 0
    }
}

struct CalculatorView: View {
    //This is a list of all of everything that should be displayed on the screen, it will usually be similar to what is in the currentWorkingValues list that is in the calculator, but not always.
    @State var currentOperations: [String] = [] {
        didSet {
            currentOperationText = ""
            for character in currentOperations {
                currentOperationText += character
            }
            if currentOperationText == "" {
                currentOperationText = "0"
            }
        }
    }
    //This holds a single String and is what the Text object is using to display the text. it updates whenever currentOperations is changed. if the character inputted is specifically "√" it will be inserted before the number in is operating on.
    @State var currentOperationText: String = "0"
    
    @State var calculator = Calculator()
    //numbersToBeCommited holds a list of Characters that will represent one number. It holds the number in a stasis so that you can edit the number and update what shows on screen without actually adding each digit of the number to the operation.
    @State var numbersToBeCommited: [Character] = [] {
        didSet {
            if numbersToBeCommited == ["0", "0"] {
                numbersToBeCommited = ["0"]
            }
        }
    }
    @State var mrButtonColor: Color = .white
    //numberInMemory holds an optional Double that will be set by pressing the M+ or M- buttons. this also changes the MR button color if there is a value stored in memory
    @State var numberInMemory: Double? = nil {
        willSet {
            if newValue != nil {
                mrButtonColor = .cyan.opacity(0.2)
            } else {
                mrButtonColor = .white
            }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            //This HStack hold the main text of the calculator
            HStack {
                Spacer()
                Text(currentOperationText)
                    .bold()
                    .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 75))
                    .padding(.horizontal, 25)
                    .lineLimit(1)
                    .truncationMode(.head)
                    .minimumScaleFactor(0.4)
            }
            //These HStacks hold all the buttons. I thought about trying to use a grid, but I gave up and decided to just stick to what I know well.
            HStack {
                Button {
                   exponentButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        
                        Text("^")
                            .padding(.top, 9)
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 22))
                            .bold()
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    sqrtButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("√")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    openParenButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("(")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    closeParenButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text(")")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
            }
            HStack {
                Button {
                    memoryAddButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("M+")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                Button {
                    memorySubtractButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("M-")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                Button {
                   memoryRecallButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(mrButtonColor)
                            .shadow(radius: 4)
                        
                        Text("MR")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                Button {
                    //MC clears the numberInMemory
                    numberInMemory = nil
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("MC")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
            }
            HStack {
                Button {
                    backspaceButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "delete.left")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 16))
                    }
                }
                Button {
                    allClear()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("AC")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                Button {
                    percentageButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("%")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 22))
                    }
                }
                Button {
                    divisionButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "divide")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
            }
            HStack {
                Button {
                    positiveNumberButton("7")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("7")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    positiveNumberButton("8")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("8")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    positiveNumberButton("9")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("9")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    mulitplicationButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "multiply")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
            }
            HStack {
                Button {
                    positiveNumberButton("4")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("4")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    positiveNumberButton("5")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("5")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    positiveNumberButton("6")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("6")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    subtractionButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "minus")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 17))
                    }
                }
            }
            HStack {
                Button {
                    positiveNumberButton("1")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("1")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    positiveNumberButton("2")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("2")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    positiveNumberButton("3")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("3")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    additionButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "plus")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 17))
                    }
                }
            }
            HStack {
                Button {
                   signChangeButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "plus.forwardslash.minus")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
                Button {
                    zeroButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("0")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                    decimalButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text(".")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 21))
                    }
                }
                Button {
                   equalsButton()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81 , height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "equal")
                            .foregroundStyle(Color(.black))
                            .bold()
                            .font(.custom("BodoniSvtyTwoITCTT-Bold", size: 18))
                    }
                }
            }
        }
    }
    //All button functions. Every operator button expect open paren will check to make sure the button pressed directly before it wasn't an operator button(with the exclusion of percantage) by running the isPreviousInvalidOperator func, and then commit all numbers that need to be added to the operation by checking for numbers that need to be commited and then calling commitNumbers. The operator buttons will then add itself to the operation in currentOperations, as well as currentWorkinValues in the Calculator struct.
    func exponentButton() {
        guard !isPreviousInvalidOperator() else {
            return
        }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        checksForDefault0()
        calculator.currentWorkingValues.append(Operators.exponent)
        currentOperations.append("^")
    }
    //The sqrtButton and the openParen button will both check what the last input was. And then if necessary add an "x" to the end for implied multiplication.
    func sqrtButton() {
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        let last = currentOperations.last
        let isOperatorOrOpenParenOrStart = last == "^" || last == "(" || last == "÷" || last == "×" || last == "-" || last == "+" || last == "√" || currentOperations.isEmpty
        
        if !isOperatorOrOpenParenOrStart {
            calculator.currentWorkingValues.append(Operators.multiply)
            currentOperations.append("×")
        }
        
        currentOperations.append("√")
        calculator.currentWorkingValues.append(Operators.squareRoot)
        calculator.currentWorkingValues.append(Operators.openParen)
        currentOperations.append("(")
    }
    func openParenButton() {
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        
        let last = currentOperations.last
        let isOperatorOrOpenParenOrStart = last == "^" || last == "(" || last == "÷" || last == "×" || last == "-" || last == "+" || last == "√" || currentOperations.isEmpty

        if !isOperatorOrOpenParenOrStart {
            calculator.currentWorkingValues.append(Operators.multiply)
            currentOperations.append("×")
        }
        
        calculator.currentWorkingValues.append(Operators.openParen)
        currentOperations.append("(")
    }
    func closeParenButton() {
        guard !isPreviousInvalidOperator() else {
            return
        }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        calculator.currentWorkingValues.append(Operators.closeParen)
        currentOperations.append(")")
    }
    //M+ and M- will perform the calculation without actually displaying it, and then save that result to the numberInMemory
    func memoryAddButton() {
        guard currentOperations.last != "(" && currentOperations.last != "÷" && currentOperations.last != "×" && currentOperations.last != "-" && currentOperations.last != "+" && currentOperations.last != "^" else { return }
        
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        calculator.calculate()
        if numberInMemory == nil {
            numberInMemory = 0 + calculator.currentValue
        } else {
            numberInMemory! += calculator.currentValue
        }
    }
    func memorySubtractButton() {
        guard currentOperations.last != "(" && currentOperations.last != "÷" && currentOperations.last != "×" && currentOperations.last != "-" && currentOperations.last != "+" && currentOperations.last != "^" else { return }
        
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        calculator.calculate()
        if numberInMemory == nil {
            numberInMemory = 0 - calculator.currentValue
        } else {
            numberInMemory! -= calculator.currentValue
        }
    }
    //MR will first run code to check if there is currently a number at the end of the operation, and if so, replace that number with the number in memory by first looping through the numberInMemory, and then adding each digit to numbersToBeCommited. And then it will add itself to the currentOperations
    func memoryRecallButton() {
        if numberInMemory != nil {
            numbersToBeCommited.removeAll()
            while (!currentOperations.isEmpty && Double(currentOperations[currentOperations.count - 1]) != nil) || (!currentOperations.isEmpty && currentOperations[currentOperations.count - 1] == ".") {
                currentOperations.removeLast()
            }
            if let validNumber = numberInMemory {
                checksForNeededMultiplier()
                for digit in String(validNumber) {
                    numbersToBeCommited.append(digit)
                }
            }
            //Here I run similar code to the format() func below, but with a few tweaks to make it work as desired.
            var numberOfDigits: Int = 0
            if let validNumber = numberInMemory {
                for _ in String(validNumber) {
                    numberOfDigits += 1
                }
                if numberOfDigits > 12 {
                    let result = validNumber.formatted(.number.notation(.scientific).precision(.fractionLength(0...8)))
                    for digit in result {
                        if digit == "," {
                            continue
                        }
                        currentOperations.append(String(digit))
                    }
                } else {
                    let result = validNumber.formatted(.number.precision(.fractionLength(0...8)))
                    for digit in result {
                        if digit == "," {
                            continue
                        }
                        currentOperations.append(String(digit))
                    }
                }
            }
            if currentOperations == ["0"] {
                allClear()
            }
        }
    }
    //The delete button will delete the last digit from all places, first it will check if there is a value to remove from currentOperations, and from numbersToBeCommited, and if so removes the last element. if removing the last number would leave an empty "E" at the end of the equation which would cause an error, it will also remove that. then it checks in currentWorkingValues in the Calculator struct to see if the last element is a number or operator. if it's an operator, it gets removed. if it's a number it pulls it out of currentWorkingValues and dissects it into numbersToBeCommited. If the number it pulls out is a round Double (eg: 68.0) it removes the last value three times to remove the 0, ., and 1 (eg: [6, 8, ., 0])
    func backspaceButton() {
        if !currentOperations.isEmpty {
            currentOperations.removeLast()
            if !currentOperations.isEmpty {
                if currentOperations[currentOperations.count - 1] == "E" {
                    currentOperations.removeLast()
                }
            }
        }
        if !numbersToBeCommited.isEmpty {
            numbersToBeCommited.removeLast()
            if !numbersToBeCommited.isEmpty {
                if numbersToBeCommited[numbersToBeCommited.count - 1] == "E" {
                    numbersToBeCommited.removeLast()
                }
            }
        } else if calculator.currentWorkingValues[calculator.currentWorkingValues.count - 1] as? Operators != nil {
            calculator.currentWorkingValues.removeLast()
        } else if calculator.currentWorkingValues[calculator.currentWorkingValues.count - 1] as? Double != nil {
            let removedValue = calculator.currentWorkingValues.removeLast() as! Double
            
            for value in String(removedValue) {
                numbersToBeCommited.append(value)
            }
            if !numbersToBeCommited.isEmpty {
                if removedValue.isRound {
                    for _ in 1...3 {
                        numbersToBeCommited.removeLast()
                    }
                } else {
                    numbersToBeCommited.removeLast()
                }
            }
        }
    }
    //Removes everything from all calculations
    func allClear() {
        numbersToBeCommited.removeAll()
        calculator.currentWorkingValues.removeAll()
        currentOperations.removeAll()
    }
    func percentageButton() {
        guard !isPreviousInvalidOperator() else {
            return
        }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        checksForDefault0()
        calculator.currentWorkingValues.append(Operators.percentage)
        currentOperations.append("%")
    }
    func divisionButton() {
        guard !isPreviousInvalidOperator() else {
            return
        }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        checksForDefault0()
        calculator.currentWorkingValues.append(Operators.divide)
        currentOperations.append("÷")
    }
    func mulitplicationButton() {
        guard !isPreviousInvalidOperator() else {
            return
        }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        checksForDefault0()
        calculator.currentWorkingValues.append(Operators.multiply)
        currentOperations.append("×")
    }
    //This button has a unique feature where instead of just running the isPreviousInvaildOperator func it will let you input a number as a negative number if there is an invalid operator directly before it.
    func subtractionButton() {
        let last = currentOperations.last
        guard last != "-" else {
            return
        }
        guard last != "^" && last != "(" && last != "÷" && last != "×" && last != "+" else {
            numbersToBeCommited.append("-")
            currentOperations.append("-")
            return
        }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        calculator.currentWorkingValues.append(Operators.minus)
        currentOperations.append("-")
    }
    func additionButton() {
        guard !isPreviousInvalidOperator() else {
            return
        }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        checksForDefault0()
        calculator.currentWorkingValues.append(Operators.plus)
        currentOperations.append("+")
    }
    //This first runs the same as all the other operators, but this is treated as an alternate "=" button, it commits the numbersToBeCommited and then runs calculate() after passing in the operation. it then runs the format func on the result, as well as added the result to numbersToBeCommited.
    func signChangeButton() {
        guard currentOperations.last != "(" && currentOperations.last != "÷" && currentOperations.last != "×" && currentOperations.last != "-" && currentOperations.last != "+" && currentOperations.last != "^" else { return }
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        calculator.currentWorkingValues.append(Operators.signChange)
        calculator.calculate()
        format(result: calculator.currentValue)
        if Double(currentOperations[0]) != nil {
            for digit in currentOperations {
                if digit == "," {
                    continue
                }
                numbersToBeCommited.append(contentsOf: digit)
            }
        }
        if currentOperations == ["0"] {
            allClear()
        }
    }
    //This finalizes the operation by commiting all numbers that need to be commited, and then runs calculate(). it then call the format func using the result of the calculation, and then adds each digit of the result to numbersToBeCommited ignoring ",".
    func equalsButton() {
        guard currentOperations.last != "(" && currentOperations.last != "÷" && currentOperations.last != "×" && currentOperations.last != "-" && currentOperations.last != "+" && currentOperations.last != "^" else { return }
        
        if !numbersToBeCommited.isEmpty {
            commitNumbers()
        }
        calculator.calculate()
        format(result: calculator.currentValue)
        if Double(currentOperations[0]) != nil {
            for digit in currentOperations {
                if digit == "," {
                    continue
                }
                numbersToBeCommited.append(contentsOf: digit)
            }
        }
        if currentOperations == ["0"] {
            allClear()
        }
    }
    //The 0 button also checks to make sure that the on screen calculation doesn't only contain a 0 before doing it's thing.
    func zeroButton() {
        guard currentOperationText != "0" else { return }
        checksForNeededMultiplier()
        numbersToBeCommited += ["0"]
        currentOperations += ["0"]
    }
    //functions similarly to all the other number buttons, but also checks to make sure you are not using more than one decimal for one number.
    func decimalButton() {
        guard !numbersToBeCommited.contains(".") else { return }
            checksForNeededMultiplier()
            checksForDefault0()
            numbersToBeCommited += ["."]
            currentOperations += ["."]
    }
    //The positive number buttons simply add the number as a string to numbersToBeCommited and currentOperations. they will also run the checkForNeedMultiplier func which checks if there is an operator directly before the inputted number that would assume any number after would be mulitiplying the result (eg: √/％), and if so first appendes .multiply to currentWorkingValues and "x" to currentOperations.
    func positiveNumberButton(_ num: String) {
        checksForNeededMultiplier()
        numbersToBeCommited += [Character(num)]
        currentOperations += [num]
    }
    
    //The commitNumbers function makes a full string from all the charactersin numbersToBeCommited by looping through all of them in a for loop and adding them to an empty string. it then puts that string into currentWorkingValues in the calculator struct as a Double. Finally it resets numbersToBeCommited to an empty array.
    func commitNumbers() {
        var numberAsString = ""
        
        for digit in numbersToBeCommited {
            numberAsString += String(digit)
        }
        calculator.currentWorkingValues.append(Double(numberAsString)!)
        numbersToBeCommited = []
    }
    
    //The format function takes in the result of the calculation as a Double, and then checks to see how many digits are in the result using a for loop. then it will either format the number with scientific notation if it's more than 12 non-fraction digits long, or format normally with up to 10 decimals of it isn't more than 12 digits. it will also get rid of any commas, and then it will add each digit of the formatted result to currentOperations.
    func format(result: Double) {
        var currentNumberOfDigits: Int = 0
        let resultAsInt: Int
        if result.isNaN {
            currentOperations = ["NaN"]
            numbersToBeCommited.removeAll()
            return
        }
        if result > Double(Int.max) {
            for _ in String(result) {
                currentNumberOfDigits += 1
            }
            if currentNumberOfDigits > 12 {
                currentOperations = []
                for digit in result.formatted(.number.notation(.scientific).precision(.fractionLength(0...8))) {
                    if digit == "," {
                        continue
                    }
                    currentOperations.append(String(digit))
                }
            } else {
                currentOperations = []
                for digit in result.formatted(.number.precision(.fractionLength(0...8))) {
                    if digit == "," {
                        continue
                    }
                    currentOperations.append(String(digit))
                }
            }
        } else {
            resultAsInt = Int(result)
            for _ in String(resultAsInt) {
                currentNumberOfDigits += 1
            }
            if currentNumberOfDigits > 12 {
                currentOperations = []
                for digit in result.formatted(.number.notation(.scientific).precision(.fractionLength(0...8))) {
                    if digit == "," {
                        continue
                    }
                    currentOperations.append(String(digit))
                }
            } else {
                currentOperations = []
                for digit in result.formatted(.number.precision(.fractionLength(0...8))) {
                    if digit == "," {
                        continue
                    }
                    currentOperations.append(String(digit))
                }
            }
        }
    }
    
    //This is a function that runs whenever a number gets inputted. see number "7" for more details.
    func checksForNeededMultiplier() {
        if !currentOperations.isEmpty {
            if currentOperations[currentOperations.count - 1] == "%" || currentOperations[currentOperations.count - 1] == ")" {
                calculator.currentWorkingValues.append(Operators.multiply)
                currentOperations.append("×")
            }
        }
    }
    //This function runs on operators when there is nothing currently in currentOperations. it will just add 0 to as a default base value.
    func checksForDefault0() {
        if currentOperations.isEmpty {
            numbersToBeCommited += ["0"]
            currentOperations += ["0"]
        }
    }
    //This function runs on most operators and will check to make sure that the previously entered value is one that can be mutated by that operator.
    func isPreviousInvalidOperator() -> Bool {
        let last = currentOperations.last
        let invalid = last == "^" || last == "(" || last == "÷" || last == "×" || last == "-" || last == "+"
        return invalid
    }
}

#Preview {
    CalculatorView()
}
