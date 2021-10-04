import UIKit

// Control Flow (흐름 제어)

// for
// 1. for ... in
let name = "123456789"
var sum = 0
for char in name {
    // cstring 때 optional 형태가 붙기 때문에 처리를 해주어야 한다.
    sum += (Int(String(char)) ?? 0)
}
print("sum in \(sum)")

let names = ["lee", "kim", "min"]
for n in names{
    print(n)
}

let numberOfLegs = ["ant": 6, "dog": 4]
for (key, value) in numberOfLegs {
    print(key, value)
}

// 2. range
for idx in 0...5 {
    print(idx)
}

for idx in 0..<5 {
    print(idx)
}

// While
var cnt = 0
while cnt < 10 {
    print(cnt)
    cnt += 1
}

// Switch
// 조건에 케이스를 만들어서 분기
// Swift는 몇 몇 타 언어와 다르게 break; 문을 안 걸어줘도 된다.
let b = "b"

switch b {
case "b":
    print("b")
case "c":
    print("c")
default:
    print("other")
}

// switch range
// 범위를 지정할 수 있다.
let n = 4
switch n {
case 1:
    print("num 1")
case 2...5:
    print("num 2 ~ 5")
default:
    print("other")
}
