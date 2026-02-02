import UIKit

enum Inputs {
    case plus, minus, multiply, divide, squareRoot, exponent, signChange, percentage, openParen, closeParen
}

struct Calculator {
    var currentValue: Double = 0
    //currentWorkingValues has all of the values that will be used in the operation. this includes type Inputs, and Double for this program. it also has a didSet that ensures it will never be empty because on a calculator the default value will always be 0.
    var currentWorkingValues: [Any] = [0.0] {
        didSet {
            if currentWorkingValues.isEmpty {
                currentWorkingValues = [0.0]
            }
        }
    }
    //This is used as a backup for currentWorkingValues when they need to be compared while calculating parenthesis
    var currentWorkingValuesBackup: [Any] = [0.0] {
        didSet {
            if currentWorkingValues.isEmpty {
                currentWorkingValues = [0.0]
            }
        }
    }

    //Takes an operation as an array with the items in the array in order of operations
    mutating func calculate() {
        //Total will be updated after every part of the operation
        var total: Double = 0
        //This is used to check what the current operator is that needs to be used for the operation
        var lastEnteredOperator: Inputs?
        //Checks for parenthesis
        var hasParens: Bool = false
        
        if currentWorkingValues.contains(where: { ($0 as? Inputs) == .openParen }) ||
           currentWorkingValues.contains(where: { ($0 as? Inputs) == .closeParen }) {
            hasParens = true
        }
        
        //Cleans Parens in case invalid parens were inputted
        if hasParens {
            let tokens = currentWorkingValues
               var stack: [Int] = []
               var removeIndexes: Set<Int> = []

               for (i, token) in tokens.enumerated() {
                   if token as? Inputs == Inputs.openParen {
                       stack.append(i)
                   }
                   else if token as? Inputs == Inputs.closeParen {
                       if stack.popLast() != nil {
                           //valid pair, do nothing
                       } else {
                           //extra closing paren
                           removeIndexes.insert(i)
                       }
                   }
               }

               //leftover opens are invalid
               for i in stack {
                   removeIndexes.insert(i)
               }

               currentWorkingValues = tokens.enumerated()
                   .filter { !removeIndexes.contains($0.offset) }
                   .map { $0.element }
            calculateParenthesis()
        }

        //Loops all of the values in the currentWorkingValuesArray in order.
        for currentWorkingValue in currentWorkingValues {
            //Checks to see if currentWorkingValue is a Double, and if it is, then checking to see if there is currently a number to mutate, and if that is true as well, then it looks at the lastEnteredOperator to see what operation to perform.
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
                default:
                    total = currentNumber
                    continue
                }
            }
            //This will check if the currentWorkingValue is an Input on the list of enum Inputs.
            if let currentInput = currentWorkingValue as? Inputs {
                //If there is currently a number to mutate, this will either store an operator to lastEnteredOperator or if it's an operator that only uses one value, it will perform the operation and update the total.
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
                default:
                    continue
                }
            }
        }
        //Once the loop is fully finished currentValue is updated to the total
        currentValue = total
        currentWorkingValues = [currentValue]
        
    }
    mutating func calculateParenthesis() {
        var indexToReplaceStart: Int?
        var indexToReplaceEnd: Int?
        var areParensEmbedded = false
        var temporaryWorkingValues = currentWorkingValues
        var unwrappedArray: [Any] = []
        var hasParens = true
        var isFinalLoop = false
        
        repeat {
            var parensOpen = false
            areParensEmbedded = false
            
            for (i, value) in temporaryWorkingValues.enumerated() {
                if value as? Inputs == .openParen {
                    if parensOpen == false {
                        indexToReplaceStart = i
                        parensOpen = true
                    } else {
                        parensOpen = false
                        areParensEmbedded = true
                        break
                    }
                }
                if value as? Inputs == .closeParen {
                    parensOpen = false
                }
            }
            
            if areParensEmbedded {
                var numberOfParenPairs = 0
                var haveParensStarted = false
                for value in temporaryWorkingValues {
                    if value as? Inputs == .openParen {
                        numberOfParenPairs += 1
                    }
                }
                
                for (i, value) in temporaryWorkingValues.enumerated() {
                    if value as? Inputs == .closeParen {
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
                    if value as? Inputs == .openParen {
                        haveParensStarted = true
                    }
                }
                
                currentWorkingValues = unwrappedArray
                calculate()
                for _ in (indexToReplaceStart!)...(indexToReplaceEnd!) {
                    temporaryWorkingValues.remove(at: indexToReplaceStart!)
                }
                temporaryWorkingValues.insert(currentValue, at: indexToReplaceStart!)
            }
        } while areParensEmbedded
        
        while hasParens {
            var haveParensStarted = false
            
            for (i, value) in temporaryWorkingValues.enumerated() {
                if value as? Inputs == .closeParen {
                    indexToReplaceEnd = i
                    haveParensStarted = false
                    break
                }
                if haveParensStarted {
                    unwrappedArray.append(value)
                }
                if value as? Inputs == .openParen {
                    indexToReplaceStart = i
                    haveParensStarted = true
                }
            }
            currentWorkingValues = unwrappedArray
            calculate()
            for _ in (indexToReplaceStart!)...(indexToReplaceEnd!) {
                temporaryWorkingValues.remove(at: indexToReplaceStart!)
            }
            temporaryWorkingValues.insert(currentValue, at: indexToReplaceStart!)
            
            if temporaryWorkingValues.contains(where: { ($0 as? Inputs) == .openParen }) ||
               temporaryWorkingValues.contains(where: { ($0 as? Inputs) == .closeParen }) {
                hasParens = true
            } else {
                hasParens = false
            }
            if !hasParens && !isFinalLoop {
                let limit = min(temporaryWorkingValues.count, currentWorkingValuesBackup.count)

                for i in 0..<limit {
                    let l = temporaryWorkingValues[i]
                    let r = currentWorkingValuesBackup[i]

                    switch (l, r) {
                    case (let ld as Double, let rd as Double):
                        if ld != rd {
                            temporaryWorkingValues.insert(Inputs.openParen, at: i)
                            break
                        }
                    case (let li as Inputs, let ri as Inputs):
                        if li != ri {
                            temporaryWorkingValues.insert(Inputs.openParen, at: i)
                            break
                        }
                    default:
                        temporaryWorkingValues.insert(Inputs.openParen, at: i)
                        break
                    }
                }
                let shared = min(temporaryWorkingValues.count, currentWorkingValuesBackup.count)

                for offset in 0..<shared {
                    // Map offset 0 -> last index, 1 -> second-to-last, etc.
                    let i = temporaryWorkingValues.count - 1 - offset
                    let j = currentWorkingValuesBackup.count - 1 - offset

                    let l = temporaryWorkingValues[i]
                    let r = currentWorkingValuesBackup[j]

                    var differs = false
                    switch (l, r) {
                    case (let ld as Double, let rd as Double):
                        differs = (ld != rd)
                    case (let li as Inputs, let ri as Inputs):
                        differs = (li != ri)
                    default:
                        // Types differ
                        differs = true
                    }

                    if differs {
                        // Insert close paren right AFTER the differing position on the left side
                        let insertIndex = min(i + 1, temporaryWorkingValues.count)
                        temporaryWorkingValues.insert(Inputs.closeParen, at: insertIndex)
                        break
                    }
                }
                isFinalLoop = true
                print(temporaryWorkingValues)
            }
            if temporaryWorkingValues.contains(where: { ($0 as? Inputs) == .openParen }) ||
               temporaryWorkingValues.contains(where: { ($0 as? Inputs) == .closeParen }) {
                hasParens = true
            } else {
                hasParens = false
            }
        }
        currentWorkingValues = temporaryWorkingValues
        calculate()
    }
}


var calculator = Calculator()
calculator.currentWorkingValues = [5.0, Inputs.multiply, Inputs.openParen, 5.0, Inputs.multiply, Inputs.openParen, 5.0, Inputs.multiply, 5.0, Inputs.closeParen, Inputs.multiply, Inputs.openParen, 10.0, Inputs.multiply, 10.0, Inputs.closeParen, Inputs.multiply, 5.0, Inputs.closeParen]


calculator.calculate()
print(calculator.currentValue)
