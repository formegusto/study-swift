import UIKit

// Function (함수)

// 계산기 만들기 -> Class
// 더하기 기능 만들기 -> Function

let a = 10
let b = 20

// 일반적으로 return이 존재하지 않으면 타입 지정을 해주지 않아도 되지만,
// swift 에서 함수는 return 값이 존재하면 반드시 리턴타입을
// 지정해줘야 한다.
func plus(n1: Int, n2: Int) -> Int {
    return n1 + n2
}

print(plus(n1: a,n2: b))

func plusWithMsg(n1: Int, n2: Int) -> (String, Int) {
    return ("결과값은", n1 + n2)
}
print(plusWithMsg(n1: 20, n2: 50))

// 매개변수명 지정하지 않는 방법
func plusWithoutName(_ n1: Int, _ n2: Int) -> Int {
    return n1 + n2
}
print(plusWithoutName(1, 2))


func minus(_ n1: Int, _ n2: Int) -> Int {
    return n1 - n2
}
func multiply(_ n1: Int, _ n2: Int) -> Int {
    return n1 * n2
}

// View, Present, Display
var inputButtonType = "-"

if inputButtonType == "+" {
    print("연산 결과", plusWithoutName(a, b))
} else if inputButtonType == "-" {
    print("연산 결과", minus(a, b))
} else if inputButtonType == "*" {
    print("연산 결과", multiply(a, b))
}

// 함수를 매개변수로 받는 방법
func displayCalc(result: (Int, Int) -> Int) {
        print("연산 결과", result(a, b))
}

inputButtonType = "*"

if inputButtonType == "+" {
    displayCalc(result: plusWithoutName)
} else if inputButtonType == "-" {
    displayCalc(result: minus)
} else if inputButtonType == "*" {
    displayCalc(result: multiply)
}
