import UIKit

var multiplyClosure = { (number: Int) -> Int in
    number * 2
}

var divisonClosure = { (number: Int) -> Int in
    number / 2
}

print(multiplyClosure(6))

func multiply(_ base: Int, times closure: (Int) -> Int ) -> Int {
    base * closure(6)
}

print(multiply(10, times: divisonClosure))
print(multiply(10, times: multiplyClosure))

struct Grader {
    var score: Int
    var gradeCalculationMethod: (Int) -> String
    var grade: String = ""
    
    init(score: Int, gradeCalculationMethod: @escaping (Int) -> String) {
        self.score = score
        self.gradeCalculationMethod = gradeCalculationMethod
    }
    
    mutating func calculateGrade() {
        grade = gradeCalculationMethod(score)
    }
}

var gradeByPercent = { (score: Int) -> String in
    String(score) + "%"
}
var gradeByLetter = { (score: Int) -> String in
    switch score {
    case 0...59:
        return "F"
    case 60...69:
        return "D"
    case 70...79:
        return "C"
    case 80...89:
        return "B"
    case 90...100:
        return "A"
    default:
        return "Enter a valid grade."
    }
}

var myGrade = Grader(score: 84, gradeCalculationMethod: gradeByPercent)

myGrade.calculateGrade()
print(myGrade.grade)

myGrade.gradeCalculationMethod = gradeByLetter
myGrade.calculateGrade()

print(myGrade.grade)


func map<T>(_ array: [T],  by mappingBy: (T) -> T) -> [T] {
    var newArray: [T] = []
    
    for element in array {
        newArray.append(mappingBy(element))
    }
    
    return newArray
}

var timesTwo = { (num: Int) -> Int in
    num * 2
}
var allCaps = { (word: String) -> String in
    word.uppercased()
}
var flipBool = { (bool: Bool) -> Bool in
    bool ? false : true
}

print(map([1, 2, 3, 4, 5, 6, 7, 8, 9, 10], by: timesTwo))
print(map(["frog", "apple", "tree"], by: allCaps))
print(map([true, true, false], by: flipBool))
print(map([5, 10, 15, 20]) { $0 * 2 })
print(map(["A", "B", "R", "U"]) { letter in "L"})

