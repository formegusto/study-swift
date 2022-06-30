# Inheritance, Generic, HOF

## Inheritance

```swift
class UserInfo {
    let name: String
    let age: Int

    init() {
        self.name = ""
        self.age = 20
    }

    init(_ name:String) {
        self.name = name
        self.age = 20
    }

    init(_ name: String, _ age: Int) {
        self.name = name
        self.age = age
    }

    func isAdult() -> Bool {
        if age > 19 {
            return true
        }
        return false
    }
}
```

**[ Basic ]** 콜론(:) 구분자를 통해 super class를 지정할 수 있다. 상속을 받게 되면, super class의 속성과 기능을 사용할 수 있다.

```swift
class Guest: UserInfo {}

let guest: Guest = Guest("forme", 27)
print(guest.name, guest.age) // forme 27
print(guest.isAdult()) // true
```

**[ Initializer ]** super class의 initializer를 overriding 하는 경우에는 sub class의 초기화 작업을 진행한 이후에 super class의 init을 실행해주어야 한다.

```swift
class Guest: UserInfo {
    let place: String

    override init(_ name: String, _ age: Int) {
        self.place = "Jeju"

        super.init(name, age)
    }
}
```

**[ override, super ]** super class의 isAdult 매개변수 형식을 그대로 따라가는 경우 1) override 키워드를 반드시 붙여주어야 한다. 2) 반환 형식이 반드시 똑같아야 한다. sub class에서 super class의 기능은 super. 키워드로 접근 가능하다.

```swift
override func isAdult() -> Bool {
    if age > 25 {
        return true
    }
    return false
}

func compareParent() -> [String:Bool] {
    return ["parent":super.isAdult(),"me":self.isAdult()]
}

let guest: Guest = Guest("forme", 23)

print(guest.isAdult()) // false
print(guest.compareParent()) // ["parent": true, "me": false]
```

## Generic

Java에서의 Generic은 데이터의 타입(data type)을 일반화(generalization)한다. 라는 것을 의미한다. 이는 특정 타입들에 대하여 더 구체적인 타입을 정의한다는 것을 말하는데, 프로그래밍적인 관점에서 Generic은 클래스나 메소드에서 사용할 내부 데이터 타입을 컴파일 타임에 미리 지정하는 방법이다. 이는 컴파일 시점에 type checking을 수행할 수 있어서 유용하다.

**[ Basic ]**

```swift
func swapToInt(_ a:inout Int, _ b:inout Int) {
    print("before : a:\(a), b:\(b)")
    let tmp = a
    a = b
    b = tmp
    print("after : a:\(a), b:\(b)")
}
var a = 0
var b = 1
swapToInt(&a, &b)
/*
before : a:0, b:1
after : a:1, b:0
*/
```

이와 같이 Swaping 기능을 수행하는 함수가 있을 때, Int로 정해져 있는 swapToInt에 Double Type을 보내게 되면 어떻게 될까?

```swift
a = 0.0
b = 1.0
// error: cannot convert value of type 'Double' to expected argument type 'Int'
swapToInt(&a, &b)
```

강력한 Type Checking 가진 Swift에서는 당연히 Error이다. 그러면 우리는 이 문제를 해결하기 위하여 Double을 매개변수로 받는 swapToDouble, String이 들어올 수도 있으니 swapToString으로 정의를 할 수도 있다.

```swift
func swapToDouble(_ a:inout Double, _ b:inout Double) {}
func swapToString(_ a:inout String, _ b:inout String) {}
```

하지만 이것이 매우 비효율적인 방법이라는 것을 우리는 알고 있다. 이럴 때 Generic을 사용하여 Int, Double, String을 일반화한다.

```swift
func swap<T>(_ a: inout T, _ b: inout T) {
    print("before : a:\(a), b:\(b)")
    let tmp = a
    a = b
    b = tmp
    print("after : a:\(a), b:\(b)")
}
```

**[ Type Constraint ]** Generic은 특정 타입만을 허용하도록 제한을 걸 수 있다. 이 때에는 Swift의 where 문법이 사용된다.

**( where overview )**

- 특정 패턴과 결합하여 조건을 추가하는 역할을 한다.

```swift
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
```

- **타입에 대한 조건 추가 -** 다음은 protocol의 확장을 나누는 방식을 통해 타입에 대한 조건을 추가하는 where 절 문법의 특징을 보여준다.

```swift
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
```

```swift
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

var myStringStack = Stack<String>()
myStringStack.push(item: "a")
myStringStack.push(item: "b")
myStringStack.push(item: "c")
```

Generic은 where 절의 두번째 특징인 타입에 대한 조건 추가를 이용하여 특정 타입들만 허용하도록 할 수 있다. Equatable은 비교가능한 변수를 뜻하는 Protocol이다. 우리가 알고 있는 비교가능한 변수라 함은 Int, String 등이 있을 것 이다. 위의 Stack 구조체는 Equatable 한 변수만을 허용한다.

```swift
// error: type 'UserInfo' does not conform to protocol 'Equatable'
class UserInfo {}
var userInfoStack = Stack<UserInfo>();
```

## HOF; Higher Order Function

Javascript에서의 Array HOF를 다루어봤다면 익숙할 내용이다. 똑같은 내용이기 때문이다. 해당 섹션에서 중점으로 봐주어야 할 것은 Swift의 HOF에서, 더 나아가 매개변수로 전달되는 Closure의 형태이다.

**[ map ]** 배열을 순회하며, Return값에 정의된 내용으로 새로운 배열을 만들어 반환한다.

```swift
Array.map(_ transform: (String) throws -> T)
```

```swift
let names2 = names.map({(name: String) -> String in
    return "\(name) taeheon"
})
print(names2)
// ["kim taeheon", "lee taeheon", "min taeheon", "john taeheon"]
```

Swift에서 Function 매개변수는 Closure의 형태로 보내줄 수 있기 때문에 HOF 또한 축약표현이 가능하다.

```swift
let names3 = names.map({(name: String) -> String in name.uppercased()})
print(names3)
// ["KIM", "LEE", "MIN", "JOHN"]
```

map 함수의 반환값은 Generic의 형태를 띄기 때문에 반환값과 배열 아이템 타입이 일치할 필요가 없다.

```swift
let nameLength = names.map{ $0.count }
print(nameLength)
// [3, 3, 3, 4]
```

**[ filter ]** 배열을 순회하며, true에 부합하는 아이템만으로 구성된 새로운 배열을 만들어 반환한다.

```swift
Array.filter(_ isIncluded:)
```

```swift
let names4 = names.filter{ $0.contains("m") }
print(names4)
// ["kim", "min"]
```

**[ reduce ]** 배열을 순회하며, 초기값으로 부터 가중값을 부여해줄 수 있다.

```swift
Array.reduce(_ initialResult: Result,
				_ nextPartialResult: (Result, String) throws -> Result)
```

Function Parameter의 또 다른 특징은 순서만 맞춰서 매개변수를 넘겨주면 되는 \_ 키워드가 기입되어 있는 형태로 함수가 구성되어 있는 경우 순서에 필요한 매개변수만 보내준 이후에 축약표현을 통해 넘겨줄 수 있다는 점 이다.

```swift
let names5 = names.reduce("") { $0 + " " + $1 }
print(names5)
// kim lee min john

let namesTotalLength = names.reduce(0) { $0 + $1.count }
print(namesTotalLength) // 13

let numArr = [1,2,3,4,5,nil,6,nil,8]
let sumNum = numArr.reduce(0) { $0 + ($1 ?? 0) }
print(sumNum) // 29
```

**[ compactMap ]** nil을 제거한 optional binding 한 형태의 map 연산 수행이 가능하다.

```swift
Array.compactMap(_ transform:)
```

```swift
let compactNumArr = numArr.compactMap { $0 }
print(compactNumArr)
//[1, 2, 3, 4, 5, 6, 8]
```

**[ flatMap ]** 2차원 배열을 1차원 배열로 flatten하게 만들 때 사용한다.

```swift
Array.flatMap(_ transform: [] -> Sequence)
```

```swift
let numbers2 = [[1,2,3], [4,5,6]]
let flatNumbers = numbers2.flatMap{ $0 }
print(flatNumbers)
// [1, 2, 3, 4, 5, 6]
```
