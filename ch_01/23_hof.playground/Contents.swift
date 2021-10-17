import UIKit

// Higher order function
// 고차 함수

let names = ["kim", "lee", "min", "john"]

// map ->
let names2 = names.map { $0 + "님"}
names2

// 반환 타입자체는 중요하지 않다.
let names3 = names.map { $0.count }
names3

// filter -> 거른다
let names4 = names.filter { $0.contains("m")}
names4

// reduce -> 하나라 뭉친다. 통합. 합친다. + -
let names5 = names.reduce("") { $0 + " " + $1 }
names5

let numberArr = [1,2,3,4,5,nil,6,nil,8]
let sumNum = numberArr.reduce(0) { $0 + ($1 ?? 0)}
sumNum

// compactMap
let numbers = numberArr.compactMap { $0 }
numbers
print("numberArr", type(of: numberArr), "numbers", type(of: numbers))

// flatmap === python flatten
let numbers2 = [[1,2,3], [4,5,6]]
let flatNumbers = numbers2.flatMap{ $0 }
flatNumbers
