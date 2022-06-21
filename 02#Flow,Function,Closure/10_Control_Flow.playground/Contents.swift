import UIKit

// Control Flow (흐름 제어)

let name: String = "123456789"
var sum: Int = 0

for char in name {
    sum += Int(String(char)) ?? 0
}
print("sum is \(sum)") // sum is 45

let names = ["lee", "kim", "min"]
for n in names {
    print(n)
}

let numberOfLegs = ["ant": 6, "dog": 4]
for (key, value) in numberOfLegs {
    print("\(key) have \(value) legs")
}
/*
 ant have 6 legs
 dog have 4 legs
*/

var numbers = Array<Int>()
for idx in 0...5 {
    numbers.append(idx)
}
print(numbers) // [0,1,2,3,4,5]

var numbers2 = [Int]()
for idx in 0..<5 {
    numbers2.append(idx)
}
print(numbers2) // [0,1,2,3,4]

var cnt = 0
while cnt < 10 {
    print(cnt)
    cnt += 1
} // 1 2 3 4 5 6 7 8 9


//// Switch
//// 조건에 케이스를 만들어서 분기
//// Swift는 몇 몇 타 언어와 다르게 break; 문을 안 걸어줘도 된다.
let b = "b"

switch b {
case "b":
    print("b")
case "c":
    print("c")
default:
    print("other")
}
// b

//
//// switch range
//// 범위를 지정할 수 있다.
let n = 4
switch n {
case 1:
    print("num 1")
case 2...5:
    print("num 2 ~ 5")
default:
    print("other")
}
