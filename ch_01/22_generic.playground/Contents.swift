import UIKit

// generic <Type>
// 로직 반복 , 타입 여러가지

// stack
// queue
// 제한 : 제한은 where 키워드로 T에 올 수 있는 것을 정하는데,
//  클래스 혹은 프로토콜 형태가 와야한다. (Int, String 과 같은 친구들 안댐 )
//  Numeric, Equatable emddl tkdydehlsek.
struct Stack<T> where T: Equatable {
    var items = [T]()
    
    mutating func push(item: T) {
        // struct는 변수의 개념이라 클래스랑 다르게 자기 멤버에 접근을 못한다.
        // 접근하고 싶다면, mutatic 키워드를 써줘야 한다.
        items.append(item)
    }
    
    mutating func pop() -> T? {
        if items.isEmpty == false {
            return items.removeLast()
        }
        return nil
    }
}

var myIntStack = Stack<Int>()

myIntStack.push(item: 4)
myIntStack.push(item: 5)
myIntStack.push(item: 6)

myIntStack.pop()
myIntStack.pop()
myIntStack.pop()
myIntStack.pop()
myIntStack.pop()

var myStringStack = Stack<String>()
myStringStack.push(item: "a")
myStringStack.push(item: "b")
myStringStack.push(item: "c")

myStringStack.pop()
myStringStack.pop()
myStringStack.pop()
myStringStack.pop()
myStringStack.pop()
