import UIKit

// Optionals (옵셔널)
// 1. 값이 있을수도 있고, 없을수도 있다.
// == 0 or null
// Tip. IOS, Apple 쪽에서는 null을 nil이라고 표현함
// 값이 있다. ( 0 -> 다쓴 상태인 값 )
var myAge: Int = 0
if myAge == 0 {
    // alert - 나이를 입력해 주세요.
}
// -> 해당의 경우에 값이 없는 상태를 표현하려 했다면 잘못된 로직이다. (Swift 언어 스펙)

// 값이 없다. == nil
var myAgePositiveNil: Int? = 0
myAgePositiveNil = nil
if myAgePositiveNil == nil {
    print("나이를 입력해주세요.")
}

var myName: String? = ""
myName = nil
if myName == nil {
    print("이름을 입력해주세요")
}

// 2. 옵셔널은 그냥 사용할 수 없는 경우가 많다.
// 2-1. 옵셔널은 타입추론되지 않는다.
var a: Int? = 10
var b: Int? = 20

// Error 발생
// note: overloads for '+' exist with these partially matching parameter lists: (Int, Int)
// var sum = a + b

// unwrapped
// unwrapping
/*
    Int? -> Int
    String? -> String
    Coalesce : ??
    Force-unwrap : !
 */
// 값이 없을 때는 0으로 대체해라
var coalesce = (a ?? 0) + (b ?? 0)
// 무조건 값이 있다고 보장
var force_unwrap = a! + b!
// 다음과 같이 nil 이 들어간 상황에서도 force-unwrap을 사용하면
// 어플이 아예 죽어버린다. 즉, 값이 꼭 있다는 확신의 상황에서 사용한다.
//a = nil
//var force_unwrap_2 = a! + b!

// 3. Unwrapping
// if Statements
if a != nil {
    // 값이 무조건 있을 때만 실행
    print(a!) // Optional인 타입은 print에 표시된다.
    // 값이 있으므로, force-unwrap을 써도된다.
}
// if let
// if var
if let hasNumber = a {
    // 값이 있으면 a의 값을 받아와서 실행
    print(hasNumber)
}
if var hasNumber = a {
    // 값을 변경하고 싶을 때, 사용
    hasNumber = hasNumber * 2
    print(hasNumber)
}

if var hasNumber = a {
    hasNumber *= 10
    print(hasNumber)
}

// guard let
// guard var
func testFunc(a: Int?) -> Int {
    //    print("testFunc start")
    // block 이기는 하지만, function 이나 method와 같이,
    // 무언가를 반환하거나 하지는 않는다.
    guard let hasNumber = a else {
        print("Has Not Number")
        return 0
    }
    // guard 문에 의해, a가 nil일 경우, 아래가 실행되지 않고,
    // 해당 함수 스코프가 종료된다.
    // 한가지 특징은 전역에서는 사용할 수 없다.
//    print(hasNumber * 10)
//    print("end")
    
    return hasNumber * 10
}
print(testFunc(a:nil)) // 0
print(testFunc(a:10)) // 100

func testFunc2(_ a: Int?) -> Int {
//    print("testFunc 2 start")
    guard var hasNumber = a else {
        print("Has Not Number")
        return 0
    }
    hasNumber = hasNumber * 2
//    print(hasNumber)
//    print("end")
    return hasNumber
}
print(testFunc2(nil))
// Has Not Number
// 0
print(testFunc2(10))
// 20
