import UIKit

// generic <Type>
// 로직 반복 , 타입 여러가지

// stack
// queue
// 제한 : 제한은 where 키워드로 T에 올 수 있는 것을 정하는데,
//  클래스 혹은 프로토콜 형태가 와야한다. (Int, String 과 같은 친구들 안댐 )
//  Numeric, Equatable 등이 사용된다

func swapToInt(_ a:inout Int, _ b:inout Int) {
    print("before : a:\(a), b:\(b)")
    let tmp = a
    a = b
    b = tmp
    print("after : a:\(a), b:\(b)")
}

func swapToDouble(_ a:inout Double, _ b:inout Double) {
    print("before : a:\(a), b:\(b)")
    let tmp = a
    a = b
    b = tmp
    print("after : a:\(a), b:\(b)")
}

func swapToString(_ a:inout String, _ b:inout String) {
    print("before : a:\(a), b:\(b)")
    let tmp = a
    a = b
    b = tmp
    print("after : a:\(a), b:\(b)")
}

//var a = 0
//var b = 1
//swapToInt(&a, &b)

var a = 0.0
var b = 1.0
// error: cannot convert value of type 'Double' to expected argument type 'Int'
//swapToInt(&a, &b)
swapToDouble(&a, &b)

func swap<T>(_ a: inout T, _ b: inout T) {
    print("before : a:\(a), b:\(b)")
    let tmp = a
    a = b
    b = tmp
    print("after : a:\(a), b:\(b)")
}

var intA = 0
var intB = 1
var doubleA = 0.0
var doubleB = 1.0
var strA = "A"
var strB = "B"
swap(&intA, &intB)
swap(&doubleA, &doubleB)
swap(&strA, &strB)

// where
// 1. for 문에서의 활용
var array: [Int] = [1,2,3,4,5,6,7,8]
for num in array where num >= 5 {
    print(num)
}
// 5 6 7 8

// 2. type casting 에서의 활용
let anyValue: Any = "any"
switch anyValue {
    case let value where value is String:
        print("It's String")
    case let value where value is Int:
        print("It's Int")
    default:
        print("I dont know,,")
} // It's String

protocol Printable {
    func printSelf()
}
extension Printable where Self: Numeric {
    func printSelf() {
        print("Number Print")
    }
}
extension Printable {
    func printSelf() {
        print("Other")
    }
}
extension Int: Printable {}
extension String: Printable {}
12.printSelf() // Number Print
"test".printSelf() // Other


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
//
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

// error: type 'UserInfo' does not conform to protocol 'Equatable'
class UserInfo {}
var userInfoStack = Stack<UserInfo>();

