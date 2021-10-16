import UIKit
import Foundation

// Closure (클로저)

// function
func myScore(a: Int) -> String {
    return "\(a)점"
}
myScore(a: 100)

// closure
// 특징1. 이름이 없다. 그래서 이름을 담아주는 변수가 필요
let myScore2 = { (a: Int) -> String in
    return "\(a)점"
}
myScore2(20)

// 축약 문법
// 1. 이와 같이 한줄로 끝나는 문들은 return 키워드를 생략할 수 있다.
// 그리고 리턴 타입추론이 가능하기 때문에 리턴타입을 지정하지 않아도 된다.
let myScore3 = { (a: Int) in
    "\(a)점"
}
myScore3(900)

// 스타일
let myScore4: (Int, Int) -> String = { (a, b) in
    "\(a + b)점"
}
myScore4(50,50)

// 파라미터 생략
// $0, $1, $2 ... $ 키워드를 사용한다. (순서 제어)
let myScroe5: (Int) -> String = {
    "\($0)점"
}
print(myScroe5(200))

// Closure 실전

// 조건 -> 특정한 글자가 포함된 것을 찾는다.
// 조건 -> 찾는다 -> 특정한 글자가 포함된 것을 찾는다.
// 조건 -> 찾는다 -> 입력한 글자로 시작하는 첫글자를 찾는다.
var names = ["apple", "air", "brown", "red", "orange", "blue", "candy"]

// 위와 같이 조건이 여러개가 있으면 기존 로직에 추가해야 한다.
// 목적은 기존것을 놔두고, 추가하는 식으로
let containsSomeText: (String, String) -> Bool = { name, find in
    if name.contains(find) {
        return true
    }
    return false
}
let isStartSomeText: (String, String) -> Bool = { name, find in
    if name.first?.description == find {
        return true
    }
    return false
}
func find(findString: String,condition: (String, String) -> Bool) -> [String] {
    var newNames = [String]()
    
    for name in names {
        if condition(name, findString) {
            newNames.append(name)
        }
    }
    
    return newNames
}

func someFind(find: String) -> [String] {
    var newNames = [String]()
    
    for name in names {
        if name.contains(find) {
            newNames.append(name)
        }
    }
    
    return newNames
}

print(someFind(find: "a"))
print("contains",find(findString: "a", condition: containsSomeText))
print("isStarted",find(findString: "a", condition: isStartSomeText))

// sort
// sort는 sorted와 다르게 리턴값이 없다.
names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
// 아래는 클로저를 사용할 수가 있다.
names.sort(by: { (lhs, rhs) in
    return lhs < rhs
})
names.sort(by: {(lhs, rhs) in
    lhs < rhs
})

// 아래와 같이 표현도 가능하다.
names.sort{(lhs, rhs) in
    lhs < rhs
}

// 그리고 클로 축약 표현을 더 사용할 수도 있다.
names.sort{ $0 < $1 }
print(names)
// 또한 names는 원래 by로 받지만, 이를 생략할 수 있는 이유는,
// 순서가 중요하지 않게됐을 때, 에러를 발생시키지 않기 때문이다. ( 파라미터 한 개일 때, )
names.sort{ $0 > $1 }
print(names)

names.sort() { $0 < $1 }
print(names)
