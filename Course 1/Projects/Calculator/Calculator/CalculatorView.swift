//
//  ContentView.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import SwiftUI

//Extension of type Double to check if a Double is a round double (eg: 78.0 vs 78.).
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
    //This holds a single String and is what the Text obeject is using to display the text. it updates whenever currentOperations is changed.
    @State var currentOperationText: String = "0" {
        willSet {
            if newValue == "0" {
                numbersToBeCommited = []
            }
        }
    }
    @State var calculator = Calculator()
    //numbersToBeCommited holds a list of Characters that will represent one number. It holds the number in a stasis so that you can edit the number and update what shows on screen without acutally adding each digit of the number to the operation.
    @State var numbersToBeCommited: [Character] = []
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
                    .font(.system(size: 75))
                    .bold()
                    .padding(.horizontal, 25)
                    .lineLimit(1)
                    .minimumScaleFactor(0.3)
            }
            //These HStacks hold all the buttons. I thought about trying to use a grid, but I gave up and decided to just stick to what I know well.
            HStack {
                //Every operator button will first commit all numbers that need to be added to the operation by checking for numbers that need to be commited and then calling commitNumbers. The operator buttons will then add itself to the operation in currentOperations, as well as currentWorkinValues in the Calculator struct.
                Button {
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    calculator.currentWorkingValues.append(Inputs.exponent)
                    currentOperations.append("^")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 171, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        
                        Text("^")
                            .padding(.top, 10)
                            .font(.title)
                            .foregroundStyle(Color(.black))
                    }
                }
                //Another operator button, see ^
                Button {if !numbersToBeCommited.isEmpty {
                    commitNumbers()
                }
                    calculator.currentWorkingValues.append(Inputs.squareRoot)
                    currentOperations.append("√")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 171, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "squareroot")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            HStack {
                Button {
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    //M+ and M- will perform the calculation without actually displaying it, and then save that result to the numberInMemory
                    calculator.calculate()
                    if numberInMemory == nil {
                        numberInMemory = 0 + calculator.currentValue
                    } else {
                        numberInMemory! += calculator.currentValue
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("M+")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    //See M+
                    calculator.calculate()
                    if numberInMemory == nil {
                        numberInMemory = 0 - calculator.currentValue
                    } else {
                        numberInMemory! -= calculator.currentValue
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("M-")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //MR will first run code to check if there is currently a number at the end of the operation, and if so, replace that number with the number in memory by first looping through the numberInMemory, and then adding each digit to numbersToBeCommited. And then it will add itself to the currentOperations
                    if numberInMemory != nil {
                        numbersToBeCommited.removeAll()
                        while (!currentOperations.isEmpty && Double(currentOperations[currentOperations.count - 1]) != nil) || (!currentOperations.isEmpty && currentOperations[currentOperations.count - 1] == ".") {
                            currentOperations.removeLast()
                        }
                        if let validNumber = numberInMemory {
                            for digit in String(validNumber) {
                                numbersToBeCommited.append(digit)
                            }
                        }
                        
                        //Here I run similar code to the format() func below, but with a few tweaks to make it work as desired.
                        var numberOfDigits: Int = 0
                        for _ in String(calculator.currentValue) {
                            numberOfDigits += 1
                        }
                        if numberOfDigits > 12 {
                            let result = calculator.currentValue.formatted(.number.notation(.scientific).precision(.fractionLength(0...8)))
                            for digit in result {
                                if digit == "," {
                                    continue
                                }
                                currentOperations.append(String(digit))
                            }
                        } else {
                            let result = calculator.currentValue.formatted(.number.precision(.fractionLength(0...8)))
                            for digit in result {
                                if digit == "," {
                                    continue
                                }
                                currentOperations.append(String(digit))
                            }
                        }
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(mrButtonColor)
                            .shadow(radius: 4)
                        
                        Text("MR")
                            .foregroundStyle(Color(.black))
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
                    }
                }
            }
            HStack {
                Button {
                    //The delete button will delete the last digit from all places, first it will check if there is a value to remove from currentOperations, and from numbersToBeCommited, and if so removes the last element. then it checks in currentWorkingValues in the Calculator struct to see if the last element is a number or operator. if it's an operator, it gets removed. if it's a number it pulls it out of currentWorkingValues and dissects it into numbersToBeCommited. If the number it pulls out is a round Double (eg: 68.0) it removes the last value three times to remove the 0, ., and 1 (eg: [6, 8, ., 0])
                    if !currentOperations.isEmpty {
                        currentOperations.removeLast()
                        if currentOperations[currentOperations.count - 1] == "E" {
                            currentOperations.removeLast()
                        }
                    }
                    if !numbersToBeCommited.isEmpty {
                        numbersToBeCommited.removeLast()
                        if numbersToBeCommited[numbersToBeCommited.count - 1] == "E" {
                            numbersToBeCommited.removeLast()
                        }
                    } else if calculator.currentWorkingValues[calculator.currentWorkingValues.count - 1] as? Inputs != nil {
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
                    print(numbersToBeCommited)
                    print(currentOperations)
                    print(calculator.currentWorkingValues)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "delete.left")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //AC simply removes all values from every array
                    numbersToBeCommited.removeAll()
                    calculator.currentWorkingValues.removeAll()
                    currentOperations.removeAll()
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("AC")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //Another operator button, see ^
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    calculator.currentWorkingValues.append(Inputs.percentage)
                    currentOperations.append("%")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "percent")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //Another operator button, see ^
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    calculator.currentWorkingValues.append(Inputs.divide)
                    currentOperations.append("÷")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "divide")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            HStack {
                Button {
                    //The number buttons simply add the number as a string to numbersToBeCommited and currentOperations.
                    numbersToBeCommited += ["7"]
                    currentOperations += ["7"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("7")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //See 7
                    numbersToBeCommited += ["8"]
                    currentOperations += ["8"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("8")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //See 7
                    numbersToBeCommited += ["9"]
                    currentOperations += ["9"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("9")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //Another operator button, see ^
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    calculator.currentWorkingValues.append(Inputs.multiply)
                    currentOperations.append("×")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "multiply")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            HStack {
                Button {
                    //See 7
                    numbersToBeCommited += ["4"]
                    currentOperations += ["4"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("4")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //See 7
                    numbersToBeCommited += ["5"]
                    currentOperations += ["5"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("5")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //See 7
                    numbersToBeCommited += ["6"]
                    currentOperations += ["6"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("6")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //Another operator button, see ^
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    calculator.currentWorkingValues.append(Inputs.minus)
                    currentOperations.append("-")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "minus")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            HStack {
                Button {
                    //See 7
                    numbersToBeCommited += ["1"]
                    currentOperations += ["1"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("1")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //See 2
                    numbersToBeCommited += ["2"]
                    currentOperations += ["2"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("2")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //See 7
                    numbersToBeCommited += ["3"]
                    currentOperations += ["3"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("3")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //Another operator button, see ^
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    calculator.currentWorkingValues.append(Inputs.plus)
                    currentOperations.append("+")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "plus")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
            HStack {
                Button {
                    //This first runs the same as all the other operators, but this is treated as an alternate "=" button, it commits the numbersToBeCommited and then runs calculate() after passing in the operation. it then runs the format func on the result, as well as added the result to numbersToBeCommited.
                    if !numbersToBeCommited.isEmpty {
                        commitNumbers()
                    }
                    calculator.currentWorkingValues.append(Inputs.signChange)
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
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "plus.forwardslash.minus")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //See 7
                    numbersToBeCommited += ["0"]
                    currentOperations += ["0"]
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text("0")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //This funtions the same as all the other numbers even though its not technically a number.
                    if !numbersToBeCommited.contains(".") {
                        numbersToBeCommited += ["."]
                        currentOperations += ["."]
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81, height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Text(".")
                            .foregroundStyle(Color(.black))
                    }
                }
                Button {
                    //This finalizes the operation by commiting all numbers that need to be commited, and then runs calculate(). it then call the format func using the result of the calculation, and then adds each digit of the result to numbersToBeCommited ignoring ",".
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
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .frame(width: 81 , height: 50)
                            .foregroundStyle(Color(.white))
                            .shadow(radius: 4)
                        
                        Image(systemName: "equal")
                            .foregroundStyle(Color(.black))
                    }
                }
            }
        }
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
}

#Preview {
    CalculatorView()
    
}
