import UIKit

// 기초 연산자
// Basic Operators

// + - * / %(remainder Operator)
let a = 20
let b = 30

let c = a + b
let d = a / b // Int Type 이라서 0이 나옴
let e = Double(a) / Double(b)
// 또한 Swift는 타입에 많이 엄격하기 때문에 다른 타입의 연산은
// 허용하지 않는다. auto casting 같은 개념이 존재하지 않음
// let e_2 = Int(a) / Double(b)

// String Operate
let aa = "hi"
let bb = "_thniii"
let cc = aa + bb

// % (remainder Operator)
// 홀수, 짝수
if a % 2 == 0 {
    print("even")
} else {
    print("odd")
}

// 실수형은 적용되지 않는다.
let bbb: Double = 30.123
bbb.truncatingRemainder(dividingBy: 2)
// 그래서 이와같은 함수를 사용한다.

// 줄임형 표현
var x = 10
x += 2
x -= 2

// Compare Operator
let m = 20
let n = 20

(m == n)
(m != n)
(m > n)
(m < n)
(m >= n)
(m <= n)

// 문자 비교 연산
let c1 = "a"
let c2 = "b"

c1 == c2
c1 != c2
c1 > c2
c1 < c2
c1 >= c2
c1 <= c2

"\u{61}"
"\u{1F495}"
