//
//  Calculator.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import Foundation
//List of mutating functions on the calculator
enum Inputs {
    case plus, minus, multiply, divide, squareRoot, exponent, signChange, percentage
}

struct Calculator {
    var currentValue: Double = 0
    var currentWorkingValues: [Any] = []
   
    //Takes an operation as an array with the items in the array in order of operations
    mutating func calculate() {
        //Total will be updated after every part of the operation
        var total: Double = 0
        //This is used to check what the current operator is that needs to be used for the operation
        var lastEnteredOperator: Inputs?
        //This will usually be the same as total, and is the number that the operation will be performed on.
        var numberToMutate: Double? = nil
        //Loops all of the values in the currentWorkingValuesArray in order.
        for currentWorkingValue in currentWorkingValues {
            //Checks to see if currentWorkingValue is a Double, and if it is, then checking to see if there is currently a number to mutate, and if that is true as well, then it looks at the lastEnteredOperator to see what operation to perform.
            if let currentNumber = currentWorkingValue as? Double {
                if let currentTotal = numberToMutate {
                    switch lastEnteredOperator {
                    case .plus:
                        total = (currentTotal + currentNumber)
                        lastEnteredOperator = nil
                    case .minus:
                        total = (currentTotal - currentNumber)
                        lastEnteredOperator = nil
                    case .multiply:
                        total = (currentTotal * currentNumber)
                        lastEnteredOperator = nil
                    case .divide:
                        total = (currentTotal / currentNumber)
                        lastEnteredOperator = nil
                    case .exponent:
                        total = pow(currentTotal, currentNumber)
                        lastEnteredOperator = nil
                    default:
                        numberToMutate = currentNumber
                        continue
                    }
                    //Changes the numberToMutate to whatever the current total is after the operation.
                    numberToMutate = total
                } else {
                    //If there was not a numberToMutate this will just set the currentNumber to the total and the numberToMutate
                    numberToMutate = currentNumber
                    total = currentNumber
                }
            }
            //This will check if the currentWorkingValue is an Input on the list of enum Inputs.
            if let currentInput = currentWorkingValue as? Inputs {
                //If there is currently a number to mutate, this will either store an operator to lastEnteredOperator or if it's an operator that only uses one value, it will perform the operation and update the total.
                if numberToMutate != nil {
                    switch currentInput {
                    case .plus:
                        lastEnteredOperator = .plus
                    case .minus:
                        lastEnteredOperator = .minus
                    case .multiply:
                        lastEnteredOperator = .multiply
                    case .divide:
                        lastEnteredOperator = .divide
                    case .exponent:
                        lastEnteredOperator = .exponent
                    case .squareRoot:
                        total = sqrt(total)
                    case .signChange:
                        if total > 0 {
                            total -= 2 * total
                        } else if total < 0 {
                            total += 2 * abs(total)
                        }
                    case .percentage:
                        total /= 100
                    }
                    numberToMutate = total
                }
            }
        }
        //Once the loop is fully finished currentValue is updated to the total
        currentValue = total
    }
}



