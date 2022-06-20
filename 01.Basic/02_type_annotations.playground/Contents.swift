// Type Annotaion
// Swift 언어 개념
// 2. Swift는 기본적으로 타입추론을 한다.
// 때문에 타입정의를 하고 싶다면 아래와 같이 사용한다.

var str: String = "Hello, playground"
var myAge: Int = 10
var screenHeight: Float = 560.10

// Error 가 난다.
// Swift에서 다른 타입간의 연산은 불가능하다.
// Type Saft
// var sum = myAge + screenHeight
var sum = myAge + Int(screenHeight)


//var str: String = "Hello, playground"
//var myAge: Int = 10
//var screenHeight: Float = 560.10

// note: overloads for '+' exist with these partially matching parameter lists: (Float, Float), (Int, Int)
// var sum = myAge + screenHeight
