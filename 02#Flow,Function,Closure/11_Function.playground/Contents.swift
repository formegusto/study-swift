import UIKit

// Function (함수)

// 계산기 만들기 -> Class
// 더하기 기능 만들기 -> Function

//let a: Int = 10
//let b: Int = 20
//
//func plus(n1: Int, n2: Int) -> Int {
//    return n1 + n2
//}
//print(plus(n1: a, n2: b)) // 30
//
//func plusWithTag(n1:Int, n2: Int) -> (String, Int) {
//    return ("더하기 결과", n1 + n2)
//}
//let (tag, sumResult) = plusWithTag(n1: a, n2: b )
//print("\(tag)는 \(sumResult) 입니다.") // 더하기 결과는 30 입니다.
//
//func plusWithoutName(_ n1: Int, _ n2: Int) -> Int {
//    return n1 + n2
//}
//print(plusWithoutName(a, b)) // 30


func plus(_ n1: Int, _ n2: Int) -> Int {
    return n1 + n2
}
func minus(_ n1: Int, _ n2: Int) -> Int {
    return n1 - n2
}

// 1) 변수나 데이터 구조에 할당 가능
let p = plus
let m = minus

print(type(of: p), type(of: m))
// (Int, Int) -> Int (Int, Int) -> Int

// 2) 전달 인자로 전달 가능
func displayCalc(_ n1: Int, _ n2:Int, _ callback: (_ n1: Int, _ n2: Int) -> Int) {
    print("계산 결과는 \(callback(n1, n2))입니다")
}
displayCalc(10, 20, p) // 계산 결과는 30입니다
displayCalc(30, 15, m) // 계산 결과는 15입니다

// 3) 반환 값으로 사용 가능
func staticCalc(_ n1: Int, _ n2:Int, _ callback: @escaping (_ n1: Int, _ n2: Int) -> Int) -> () -> Int {
    let urCalc = {() -> Int in
        return callback(n1, n2)
    }
    
    return urCalc
}
let myCalc10 = staticCalc(20, 10, m)
print(myCalc10()) // 10
