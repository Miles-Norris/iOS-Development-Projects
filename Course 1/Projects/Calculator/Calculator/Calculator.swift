//
//  Calculator.swift
//  Calculator
//
//  Created by Miles Norris on 1/28/26.
//

import Foundation

// List of mutating functions on the calculator
enum Operators {
    case plus, minus, multiply, divide, squareRoot, exponent, signChange, percentage, openParen, closeParen
}

protocol Inputs { }

extension Operators: Inputs { }
extension Double: Inputs { }

struct Calculator {
    var isMiniCalc = false
    var currentValue: Double = 0
    
    // currentWorkingValues has all of the values that will be used in the operation. this includes type Operators, and Double for this program. it also has a didSet that ensures it will never be empty because on a calculator the default value will always be 0.
    var currentWorkingValues: [any Inputs] = [0.0] {
        didSet {
            if currentWorkingValues.isEmpty {
                currentWorkingValues = [0.0]
            }
        }
    }
    
    // Takes an operation as an array
    mutating func calculate() {
        
        // Total will be updated after every part of the operation
        var total: Double = 0
        
        //T his is used to check what the current operator is that needs to be used for the operation
        var lastEnteredOperator: Operators?
        
        // hecks for parentheses, Exponents/Sqrts, and Multiplication/Divison/Percentages.
        var hasParens = false
        var hasExponentOrSqrt = false
        var hasMuliplyOrDivideOrPercentage = false
        
        // In order to follow order of operations. the next 75ish lines of code checks for their respective operator type and then performs the respective calculate operator function.
        if currentWorkingValues.contains(where: { ($0 as? Operators) == .openParen }) ||
            currentWorkingValues.contains(where: { ($0 as? Operators) == .closeParen }) {
            hasParens = true
        }
        
        // Cleans Parens in case invalid parens were inputted
        if hasParens {
            let tokens = currentWorkingValues
            var stack: [Int] = []
            var removeIndexes: Set<Int> = []
            
            for (i, token) in tokens.enumerated() {
                if token as? Operators == Operators.openParen {
                    stack.append(i)
                }
                else if token as? Operators == Operators.closeParen {
                    if stack.popLast() != nil {
                        //valid pair, do nothing
                    } else {
                        //extra closing paren
                        removeIndexes.insert(i)
                    }
                }
            }
            
            // Leftover opens are invalid
            for i in stack {
                removeIndexes.insert(i)
            }
            
            currentWorkingValues = tokens.enumerated()
                .filter { !removeIndexes.contains($0.offset) }
                .map { $0.element }
            // Once the parenthesis are clean, it will run the calculateParentheses function to calculate them.
            if currentWorkingValues.contains(where: { ($0 as? Operators) == .openParen }) ||
                currentWorkingValues.contains(where: { ($0 as? Operators) == .closeParen }) {
                hasParens = true
            } else {
                hasParens = false
            }
            if hasParens {
                calculateParentheses()
            }
        }
        
        if currentWorkingValues.contains(where: { ($0 as? Operators) == .exponent }) ||
            currentWorkingValues.contains(where: { ($0 as? Operators) == .squareRoot }) {
            hasExponentOrSqrt = true
        }
        
        if hasExponentOrSqrt && !isMiniCalc {
            calculateExponentsAndSqrts()
        }
        
        if currentWorkingValues.contains(where: { ($0 as? Operators) == .multiply }) ||
            currentWorkingValues.contains(where: { ($0 as? Operators) == .divide }) ||
            currentWorkingValues.contains(where: { ($0 as? Operators) == .percentage }){
            hasMuliplyOrDivideOrPercentage = true
        }
        
        if hasMuliplyOrDivideOrPercentage && !isMiniCalc {
            calculateMultiplyAndDivideAndPercentage()
        }
        
        // Loops all of the values in the currentWorkingValuesArray in order.
        for currentWorkingValue in currentWorkingValues {
            // Checks to see if currentWorkingValue is a Double, and if it is, it then it looks at the lastEnteredOperator to see what operation to perform.
            if let currentNumber = currentWorkingValue as? Double {
                switch lastEnteredOperator {
                case .plus:
                    total = (total + currentNumber)
                    lastEnteredOperator = nil
                case .minus:
                    total = (total - currentNumber)
                    lastEnteredOperator = nil
                case .multiply:
                    total = (total * currentNumber)
                    lastEnteredOperator = nil
                case .divide:
                    total = (total / currentNumber)
                    lastEnteredOperator = nil
                case .exponent:
                    total = pow(total, currentNumber)
                    lastEnteredOperator = nil
                case .squareRoot:
                    total = currentNumber.squareRoot()
                    lastEnteredOperator = nil
                default:
                    total = currentNumber
                    continue
                }
            }
            // This will check if the currentWorkingValue is an Operator on the list of enum Operators.
            if let currentOperator = currentWorkingValue as? Operators {
                // This will either store an operator to lastEnteredOperator or if it's an operator that only uses one value, it will perform the operation and update the total.
                switch currentOperator {
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
                    lastEnteredOperator = .squareRoot
                case .signChange:
                    if total > 0 {
                        total -= 2 * total
                    } else if total < 0 {
                        total += 2 * abs(total)
                    }
                case .percentage:
                    total /= 100
                default:
                    continue
                }
            }
        }
        // Once the loop is fully finished currentValue is updated to the total
        currentValue = total
        currentWorkingValues = [currentValue]
        
    }
    // This is the function to calculate the parentheses in the equation. it's super cringe and writing it made me want to jump into incoming traffic. Even reading it breaks my brain, but it works so trust the process.
    mutating func calculateParentheses() {
        // indexToReplaceStart and End pinpoint the beginning and end of the parentheses. We use these later to know what values in the original equation we need to replace with the result of the parentheses.
        var indexToReplaceStart: Int?
        var indexToReplaceEnd: Int?
        // This is used to check wether the parentheses are emebedded inside of more parentheses, so we know to unwrap/unembbed them.
        var areParensEmbedded = false
        // We copy the original equation so that we can use currentWorkingValues during this function.
        var temporaryWorkingValues = currentWorkingValues
        // We copy every value between the parentheses to this unwrappedArray. We then run calculate() on this to get calculate the parentheses and then pass the result back into the main equation.
        var unwrappedArray: [any Inputs] = []
        var hasParens = true
        var parensOpen = false
        
        // This for loop will check to see if any parentheses pairs are opened while there is currently a pair opened, and if there is, it knows the parentheses are embedded. this also assigns the position of the first open parenthesis as indexToReplaceStart.
        for (i, value) in temporaryWorkingValues.enumerated() {
            if value as? Operators == .openParen {
                if parensOpen == false {
                    indexToReplaceStart = i
                    parensOpen = true
                } else {
                    parensOpen = false
                    areParensEmbedded = true
                    break
                }
            }
            if value as? Operators == .closeParen {
                parensOpen = false
            }
        }
        
        // If the parentheses are embedded, this is the code it will run to unwrap them.
        if areParensEmbedded {
            var numberOfParenPairs = 0
            var haveParensStarted = false
            // First we go through and check how many pairs of parentheses are in the equation.
            for value in temporaryWorkingValues {
                if value as? Operators == .openParen {
                    numberOfParenPairs += 1
                }
            }
            
            // This will loop through all of the values and once it hits the first open parentheses, it will start adding each value to unwrappedArray until it finds the end of all the parentheses.
            for (i, value) in temporaryWorkingValues.enumerated() {
                //Every time it hits a close parentheses it minuses 1 from numberOfParenPairs until it closes every pair.
                if value as? Operators == .closeParen {
                    numberOfParenPairs -= 1
                    if numberOfParenPairs == 0 {
                        indexToReplaceEnd = i
                        haveParensStarted = false
                        break
                    }
                }
                if haveParensStarted {
                    unwrappedArray.append(value)
                }
                if value as? Operators == .openParen {
                    haveParensStarted = true
                }
            }
            
            // Now we assign unwrappedArray to currentWorkingValues and calculate it. Note that at this point we still have parentheses in the equation, so when we calculate now, it will see the parentheses and run calculateParentheses again it will continue this until it runs of parentheses to calculate. Once it doesn't see any embedded parentheses it will use the code below to calculate them insted of this loop.
            currentWorkingValues = unwrappedArray
            calculate()
            // after it's done calculating, it will use the 2 index found previously to remove all the values within the parentheses and then replace that will the value gotten from the calculation.
            for _ in (indexToReplaceStart! + 1)...(indexToReplaceEnd! - 1) {
                temporaryWorkingValues.remove(at: indexToReplaceStart! + 1)
            }
            temporaryWorkingValues.insert(currentValue, at: indexToReplaceStart! + 1)
        }
        
        // This is the code that runs when there aren't any embedded parentheses.
        while hasParens {
            var haveParensStarted = false
            
            // This is very similar to the previous loop, but this time it will only go until it finishes one pair.
            for (i, value) in temporaryWorkingValues.enumerated() {
                if value as? Operators == .closeParen {
                    indexToReplaceEnd = i
                    haveParensStarted = false
                    break
                }
                if haveParensStarted {
                    unwrappedArray.append(value)
                }
                if value as? Operators == .openParen {
                    indexToReplaceStart = i
                    haveParensStarted = true
                }
            }
            // This is the same as before, it will calculate the first pair of parentheses, replace that pair in the original equation with the result, and then repeat the process until all pairs have been calculated.
            currentWorkingValues = unwrappedArray
            calculate()
            
            for _ in (indexToReplaceStart!)...(indexToReplaceEnd!) {
                temporaryWorkingValues.remove(at: indexToReplaceStart!)
            }
            
            temporaryWorkingValues.insert(currentValue, at: indexToReplaceStart!)
            
            if temporaryWorkingValues.contains(where: { ($0 as? Operators) == .openParen }) ||
                temporaryWorkingValues.contains(where: { ($0 as? Operators) == .closeParen }) {
                hasParens = true
            } else {
                hasParens = false
            }
            
        }
        // Finally it assigns the new equation to currentWorkingValues and calculate it one more time for the final result.
        currentWorkingValues = temporaryWorkingValues
        calculate()
    }
    
    // This functions almost the same of the previous one, using recursive functions to calculate just the expression it needs to. This one just needs less steps than the last one.
    mutating func calculateExponentsAndSqrts() {
        var arrayForCalculation: [any Inputs] = []
        var hasExponentOrSqrt = true
        var temporaryWorkingValues = currentWorkingValues
        var indexToInsertAt: Int?
        var numberOfRemovals = 0
        
        while hasExponentOrSqrt {
            for (i, value) in temporaryWorkingValues.enumerated() {
                if value as? Operators == .squareRoot {
                    indexToInsertAt = i
                    numberOfRemovals = 2
                    if temporaryWorkingValues[indexToInsertAt! + 1] as? Double != nil {
                        arrayForCalculation.append(value)
                        arrayForCalculation.append(temporaryWorkingValues[indexToInsertAt! + 1])
                        break
                    }
                }
                if value as? Operators == .exponent {
                    indexToInsertAt = i - 1
                    numberOfRemovals = 3
                    if temporaryWorkingValues[indexToInsertAt!] as? Double != nil && temporaryWorkingValues[indexToInsertAt! + 2] as? Double != nil {
                        arrayForCalculation.append(temporaryWorkingValues[indexToInsertAt!])
                        arrayForCalculation.append(value)
                        arrayForCalculation.append(temporaryWorkingValues[indexToInsertAt! + 2])
                        break
                    }
                }
            }
            currentWorkingValues = arrayForCalculation
            
            // If we didn't have the isMiniCalc Bool here, it would infinitly loop this function because every time it would go to calculate it, it would see the operator present again and come back to this function to calculate it.
            isMiniCalc = true
            calculate()
            isMiniCalc = false
            
            for _ in 1...numberOfRemovals {
                temporaryWorkingValues.remove(at: indexToInsertAt!)
            }
            
            temporaryWorkingValues.insert(currentValue, at: indexToInsertAt!)
            currentWorkingValues = temporaryWorkingValues
            
            if currentWorkingValues.contains(where: { ($0 as? Operators) == .exponent }) ||
                currentWorkingValues.contains(where: { ($0 as? Operators) == .squareRoot }) {
                hasExponentOrSqrt = true
            } else {
                hasExponentOrSqrt = false
            }
        }
    }
    // Again, almost the same function, just with small tweaks
    mutating func calculateMultiplyAndDivideAndPercentage() {
        var arrayForCalculation: [any Inputs] = []
        var hasMulitplyOrDivideOrPercentage = true
        var temporaryWorkingValues = currentWorkingValues
        var indexToInsertAt: Int?
        var numberOfRemovals = 0
        
        while hasMulitplyOrDivideOrPercentage {
            for (i, value) in temporaryWorkingValues.enumerated() {
                if value as? Operators == .multiply || value as? Operators == .divide {
                    indexToInsertAt = i - 1
                    numberOfRemovals = 3
                    if temporaryWorkingValues[indexToInsertAt!] as? Double != nil && temporaryWorkingValues[indexToInsertAt! + 2] as? Double != nil {
                        arrayForCalculation.append(temporaryWorkingValues[indexToInsertAt!])
                        arrayForCalculation.append(value)
                        arrayForCalculation.append(temporaryWorkingValues[indexToInsertAt! + 2])
                        break
                    }
                }
                if value as? Operators == .percentage {
                    indexToInsertAt = i - 1
                    numberOfRemovals = 2
                    if temporaryWorkingValues[indexToInsertAt!] as? Double != nil {
                        arrayForCalculation.append(temporaryWorkingValues[indexToInsertAt!])
                        arrayForCalculation.append(value)
                        break
                    }
                }
            }
            
            currentWorkingValues = arrayForCalculation
            isMiniCalc = true
            calculate()
            isMiniCalc = false
            
            for _ in 1...numberOfRemovals {
                temporaryWorkingValues.remove(at: indexToInsertAt!)
            }
            
            temporaryWorkingValues.insert(currentValue, at: indexToInsertAt!)
            currentWorkingValues = temporaryWorkingValues
            
            if currentWorkingValues.contains(where: { ($0 as? Operators) == .multiply }) ||
                currentWorkingValues.contains(where: { ($0 as? Operators) == .divide }) ||
                currentWorkingValues.contains(where: { ($0 as? Operators) == .percentage }) {
                hasMulitplyOrDivideOrPercentage = true
            } else {
                hasMulitplyOrDivideOrPercentage = false
            }
        }
    }
}



