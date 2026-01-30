import UIKit

//List of mutating functions on the calculator
enum Inputs {
    case plus, minus, multiply, divide, squareRoot, exponent, signChange, percentage
}

struct Calculator {
    var currentValue: Double = 0
    var currentWorkingValues: [Any] = [0.0]
   
    //Takes an operation as an array with the items in the array in order of operations
    mutating func calculate() {
        //Total will be updated after every part of the operation
        var total: Double = 0
        //This is used to check what the current operator is that needs to be used for the operation
        var lastEnteredOperator: Inputs?
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
                }
            }
        }
        //Once the loop is fully finished currentValue is updated to the total
        currentValue = total
    }
}

var calculator = Calculator()

calculator.currentWorkingValues = [0.0, Inputs.divide, 0.0]
calculator.calculate()

print(calculator.currentValue)
