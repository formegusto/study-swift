import UIKit

// Higher order function
// 고차 함수

let names = ["kim", "lee", "min", "john"]

// [map]
let names2 = names.map({(name: String) -> String in
    return "\(name) taeheon"
})
print(names2)
// ["kim taeheon", "lee taeheon", "min taeheon", "john taeheon"]

let names3 = names.map({(name: String) -> String in name.uppercased()})
print(names3)
// ["KIM", "LEE", "MIN", "JOHN"]

let nameLength = names.map{ $0.count }
print(nameLength)
// [3, 3, 3, 4]

// [filter]
let names4 = names.filter{ $0.contains("m") }
print(names4)
// ["kim", "min"]

let names5 = names.reduce("") { $0 + " " + $1 }
print(names5)
// kim lee min john

// [reduce]
let namesTotalLength = names.reduce(0) { $0 + $1.count }
print(namesTotalLength) // 13

let numArr = [1,2,3,4,5,nil,6,nil,8]
let sumNum = numArr.reduce(0) { $0 + ($1 ?? 0) }
print(sumNum) // 29

// [compactMap]
let compactNumArr = numArr.compactMap { $0 }
print(compactNumArr)
//[1, 2, 3, 4, 5, 6, 8]

// [flatMap]
let numbers2 = [[1,2,3], [4,5,6]]
let flatNumbers = numbers2.flatMap{ $0 }
print(flatNumbers)
// [1, 2, 3, 4, 5, 6]
