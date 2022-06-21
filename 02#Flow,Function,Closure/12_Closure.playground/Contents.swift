import UIKit
import Foundation

// Closure (클로저)

let myScore = {(a:Int) -> String in
    return "\(a)점"
}
print(myScore(90)) // 90점

let myScore2 = {(a:Int) in "\(a)점"}
print(myScore2(100)) // 100점
//let myScore3: (Int, Int) -> String = {
//    (a: Int, b:Int) in "\(a + b)점"
//}
//print(myScore3(50,50)) // 100점

let myScore3: (Int, Int) -> String = { "\($0 + $1)점" }
print(myScore3(100,100)) // 200점

// Closure 실전
var names = ["apple", "air", "brown", "red", "orange", "blue", "candy"]
let containsSomeText: (String, String) -> Bool = {
    if $0.contains($1) {
        return true
    }
    return false
}
let isStartSomeText: (String, String) -> Bool = {
    if $0.first?.description == $1 {
        return true
    }
    return false
}
func find(findString: String, condition: (String, String) -> Bool) -> [String] {
    var newNames = [String]()
    for name in names {
        if condition(name, findString) {
            newNames.append(name)
        }
    }
    return newNames
}
print(find(findString: "a", condition: containsSomeText))
// ["apple", "air", "orange", "candy"]
print(find(findString: "a", condition: isStartSomeText))
// ["apple", "air"]

names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
names.sort(by: {(lhs, rhs) in
    return lhs < rhs
})
print(names) // ["Alex", "Barry", "Chris", "Daniella", "Ewa"]

names.sort(by: { return $0 > $1 })
print(names) // ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

names.sort{ $0 < $1 }
print(names) // ["Alex", "Barry", "Chris", "Daniella", "Ewa"]

//
//// sort
//// sort는 sorted와 다르게 리턴값이 없다.
//names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//// 아래는 클로저를 사용할 수가 있다.
//names.sort(by: { (lhs, rhs) in
//    return lhs < rhs
//})
//names.sort(by: {(lhs, rhs) in
//    lhs < rhs
//})
//
//// 아래와 같이 표현도 가능하다.
//names.sort{(lhs, rhs) in
//    lhs < rhs
//}
//
//// 그리고 클로 축약 표현을 더 사용할 수도 있다.
//names.sort{ $0 < $1 }
//print(names)
//// 또한 names는 원래 by로 받지만, 이를 생략할 수 있는 이유는,
//// 순서가 중요하지 않게됐을 때, 에러를 발생시키지 않기 때문이다. ( 파라미터 한 개일 때, )
//names.sort{ $0 > $1 }
//print(names)
//
//names.sort() { $0 < $1 }
//print(names)
