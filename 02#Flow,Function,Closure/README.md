# 02#Flow, Function, Closure

# Control Flow

**[for … in]** for each 문을 상상하면 된다.

```swift
let name: String = "123456789"
var sum: Int = 0

for char in name {
    sum += Int(String(char)) ?? 0
}
print("sum is \(sum)") // sum is 45
```

이 때 Int(String(char))와 같은 문법을 작성한 이유는 **Int() 캐스팅 함수는 String.Element (aka Character) Type의 매개변수를 지원하지 않는다.** 그렇기 때문에 String 타입으로 변경해주어야 하고, **당연히 parseError가 발생하여 값이 존재하지 않을 수 있어서 Int? 형태의 Optional Type을 반환**한다. 그렇기 때문에 unwrapping 처리를 해주어야 한다.

```swift
let names = ["lee", "kim", "min"]
for n in names {
    print(n)
}

// 배열은 물론 dictionary type과 같은 enumrable type들에
// for each 연산을 수행시킬 수 있다.
let numberOfLegs = ["ant": 6, "dog": 4]
for (key, value) in numberOfLegs {
    print("\(key) have \(value) legs")
}
/*
 ant have 6 legs
 dog have 4 legs
*/
```

**[range]**

```swift
var numbers = Array<Int>()
for idx in 0...5 {
    numbers.append(idx)
}
print(numbers) // [0,1,2,3,4,5]
```

Swift의 range 문법은 … 연산자에 의해 동작한다. 0…5는 0부터 5까지(5를 포함)의 범위를 이야기 한다.

```swift
var numbers2 = [Int]()
for idx in 0..<5 {
    numbers2.append(idx)
}
print(numbers2) // [0,1,2,3,4]
```

이와 같이 Python의 range 함수 처럼 동작하도록 할 수도 있다. 0..<5는 0부터 5까지의 범위를 이야기 한다.

**[while]**

```swift
var cnt = 0
while cnt < 10 {
    print(cnt)
    cnt += 1
} // 1 2 3 4 5 6 7 8 9
```

**[switch … case … default]**

```swift
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
```

Swift 에서의 switch case 문은 break 문으로 끝을 지정해주지 않아도 된다는 특징을 가지고 있다.

**[switch range]**

```swift
let n = 4
switch n {
case 1:
    print("num 1")
case 2...5:
    print("num 2 ~ 5")
default:
    print("other")
}
```

for range 문과 마찬가지로 … 연산자를 사용하여 분기 조건에 범위를 설정해줄 수 있다.

# Function

**[Basic]**

```swift
let a: Int = 10
let b: Int = 20

func plus(n1: Int, n2: Int) -> Int {
    return n1 + n2
}
print(plus(n1: a, n2: b)) // 30

func plusWithTag(n1:Int, n2: Int) -> (String, Int) {
    return ("더하기 결과", n1 + n2)
}
let (tag, sumResult) = plusWithTag(n1: a, n2: b )
print("\(tag)는 \(sumResult) 입니다.") // 더하기 결과는 30 입니다.
```

Swift에서의 함수 정의는 “func 함수명(매개변수: 변수 타입, …) → 반환타입” 으로 구성되어 있다. 이 때 return문에 대해서는 타입 추론을 진행하지 않기 때문에 반환값이 있다면 반드시 타입 지정을 진행해주어야 한다.

```swift
func plusWithoutName(_ n1: Int, _ n2: Int) -> Int {
    return n1 + n2
}
print(plusWithoutName(a, b)) // 30
```

또한 매개변수 앞에 \_ 연산자를 넣어주지 않으면 무조건 매개변수의 이름을 지정하여 전달해주어야 한다. 이 때는 순서를 무조건적으로 맞춰주어야 한다.

**[Swift Function is First-class Citizen]**

Swift는 함수형 언어로 제작되었다. 함수형 언어의 특징은 함수를 일급 객체로 취급한다는 점 인데 Javascript와 마찬가지로 함수를 일급객체로 취급하게 되면 1) 변수나 데이터 구조에 할당 가능, 2) 전달 인자로 전달 가능 , 3) 반환 값으로 사용가능과 같은 동작을 취할 수 있게 된다.

```swift
func plus(_ n1: Int, _ n2: Int) -> Int {
    return n1 + n2
}
func minus(_ n1: Int, _ n2: Int) -> Int {
    return n1 - n2
}
func multiply(_ n1: Int, _ n2: Int) -> Int{
    return n1 * n2
}
```

**1) 변수나 데이터 구조에 할당 가능**

```swift
let p = plus
let m = minus

print(type(of: p), type(of: m))
// (Int, Int) -> Int (Int, Int) -> Int
```

**2) 전달 인자로 전달 가능**

```swift
func displayCalc(_ n1: Int, _ n2:Int, _ callback: (_ n1: Int, _ n2: Int) -> Int) {
    print("계산 결과는 \(callback(n1, n2))입니다")
}
displayCalc(10, 20, p) // 계산 결과는 30입니다
displayCalc(30, 15, m) // 계산 결과는 15입니다
```

**3) 반환 값으로 사용가능**

```swift
func staticCalc(_ n1: Int, _ n2:Int, _ callback: @escaping (_ n1: Int, _ n2: Int) -> Int) -> () -> Int {
    let urCalc = {() -> Int in
        return callback(n1, n2)
    }
    return urCalc
}
let myCalc10 = staticCalc(20, 10, m)
print(myCalc10()) // 10
```

# Closure

클로저는 사용자의 코드 안에서 전달되어 사용할 수 있는 로직을 가진 중괄호로 구분된 코드의 블럭을 말한다. 이는 일급 객체의 역할을 할 수 있는데, Swift에서 함수가 일급객체의 역할을 할 수 있는 것이 Swift의 함수는 클로저로 만들어진 이름을 가지고 있는 클로저이기 때문이다.

**[Feature # 1] 자체적으로 이름을 가지고 있지 않기 때문에 변수에 할당해주어야 한다.**

```swift
let myScore = {(a:Int) -> String in
    return "\(a)점"
}
print(myScore(90)) // 90점
```

**[Feature # 2] 한줄로 끝나는 문법은 return 키워드를 생략할 수 있다. 이 때 함수와는 다르게 타입추론을 할 수 있기 때문에 반환 타입 또한 생략 가능해진다.**

```swift
let myScore2 = {(a:Int) in "\(a)점"}
print(myScore2(100)) // 100점

// 타입 지정도 물론 가능!
let myScore2: (Int, Int) -> String = {
    (a: Int, b:Int) in "\(a + b)점"
}
print(myScore2(50,50)) // 100점
```

**[Feature # 3] 타입 지정 후 Closure 선언 시 파라미터 정의 부터 in문 까지 생략 가능 하다 이때 파라미터에는 $0, $1, … 와 같이 파라미터 순서대로 접근한다.**

```swift
let myScore3: (Int, Int) -> String = { "\($0 + $1)점" }
print(myScore3(100,100)) // 200점
```

이러한 클로저는 다른 언어의 람다(lambda)와 비슷하다. 즉 자바스크립트 배열의 고차함수, python의 apply 등과 같은 lambda 식과 동일한 기능으로 사용이 가능하며, 이는 기능 확장에 용이하다.

**[기능 확장 예시]**

```swift
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
```

```swift
var names = ["apple", "air", "brown", "red", "orange", "blue", "candy"]
func find(findString: String, condition: (String, String) -> Bool) -> [String] {
    var newNames = [String]()
    for name in names {
        if condition(name, findString) {
            newNames.append(name)
        }
    }
    return newNames
}

// 하나의 함수를 통해 2개의 기능으로 확장시킬 수 있다.
print(find(findString: "a", condition: containsSomeText))
// ["apple", "air", "orange", "candy"]
print(find(findString: "a", condition: isStartSomeText))
// ["apple", "air"]
```

**[고차함수에 이용되는 클로저]**

```swift
names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
// names.sort(by: (String, String) throws -> Bool)

names.sort(by: {(lhs, rhs) in
    return lhs < rhs
})
print(names) // ["Alex", "Barry", "Chris", "Daniella", "Ewa"]

// 모든 축약 표현이 가능하다.
names.sort(by: { return $0 > $1 })
print(names) // ["Ewa", "Daniella", "Chris", "Barry", "Alex"]
```

```swift
names.sort{ $0 < $1 }
print(names) // ["Alex", "Barry", "Chris", "Daniella", "Ewa"]
```

이런 것도 가능하다. 이런 경우에는 sort 함수가 by 라는 매개변수 하나만을 소유하고 있는 경우이다. 순서가 중요하지 않기 때문에 극단적인 위와 같은 축약표현도 가능하다.
