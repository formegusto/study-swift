# 1. Swift 문법 학습

# 변수, 상수

```swift
// 변수
var str: String = "Hello, playground"
var age: Int = 10

// 상수
let myAge = 10
```

Swift에서 변수는 var, 상수는 let으로 표현되어 진다. Swift 언어는 TypeSafe Language, Strong Type, Strict Type 이다. Type을 기입해주지 않으면 자동으로 타입추론에 들어가서 변수의 타입이 정해진다.

# Type Annotations

```swift
var str: String = "Hello, playground"
var myAge: Int = 10
var screenHeight: Float = 560.10
```

이와 같이 변수의 타입을 개발자가 지정해주는 것을 Type Annotation 이라고 부른다. 하지만 Type Annotation을 기입해주지 않아도 Swift는 기본적으로 타입추론을 한다.

```swift
var sum = myAge + screenHeight
// note: overloads for '+' exist with
//   these partially matching parameter lists: (Float, Float), (Int, Int)

var sum = myAge + Int(screenHeight)
```

[TypeSafe Language] Swift에서는 다른 타입간의 연산을 허용하지 않는다. 그게 같은 숫자 타입인 Float, Int의 연산이라도 말이다. 다른 타입간의 연산은 무조건 캐스팅을 취해준 이후에 진행해야 한다.

# Boolean

```swift
var isOpen: Bool = true

if isOpen {
    print("is Opened!")
} else {
    print("isn't Opened!")
}

if !isOpen {
    print("isn't Opened!")
} else {
    print("is Opened!")
}
```

Swift에서 조건절 검사의 괄호는 Optional 이다.

# Tuples

```swift
var topTitle = ("메인화면", "mainIcon.png")

print(topTitle.0) // 메인화면
print(topTitle.1) // mainIcon.png
```

연속적인 값을 가지고 있는 Tuples를 정의한다. 이 때, topTitle의 타입은 (String, String)이다. XCode에서 타입의 확인은 Option 버튼을 누르고 변수를 클릭하면 가능하다.

```swift
var httpOk = (200, "success")
var httpError = (404, "Page Not Found")
```

Tuples에 속하는 값들은 타입이 달라도 된다.

```swift
var httpUnauth = (statusCode: 401, description: "Unauthorized")

print(httpUnauth.statusCode)
print(httpUnauth.description)
```

다음과 같이 key값을 지정해주고, key값을 통하여 조회할 수도 있다. 위와 같은 경우에 httpUnauth의 타입은 (statusCode: Int, description: String) 이다.

# Optional

**[Optional 이란]** Typescript에서는 값이 있을 수도 있고 없을 수도 있음을 나타낸다. 이 때 값의 여부는 Truthy, Falsy한 값을 나타내는게 아니고 정말 그냥 없는 것이다. undefined, Swift에서는 이러한 null, undefined 값을 nil로 나타낸다.

```swift
var myAgePositiveNil: Int? = 0
myAgePositiveNil = nil
if myAgePositiveNil == nil {
    print("나이를 입력해주세요")
}
```

**[Optional은 그냥 사용할 수 없는 경우가 많다.]** 그 이유는 Optional로 정의된 자료형의 변수는 Swift의 타입추론이 진행되지 않기 때문에 그냥 사용할 수 없다. 이러한 Optional 변수를 개발자의 판단하에 처리하는 방법들을 Optional Unwrapping이라고 한다. 이 때, Unwrapping(추출)이라고 하는 이유는 Swift에서 Optional 타입들은 일반적인 숫자나 문자열이 아닌 Optional 객체로서 동작하기 때문이다. 숫자 혹은 문자열의 “값”을 추출(Unwrapping) 해주어야 한다.

```swift
var a: Int? = 10
var b: Int? = 20

// note: overloads for '+' exist with
// these partially matching parameter lists: (Int, Int)
var sum = a + b
```

**[Optional Unwrapping 1.Nil coalescing]** Optional Checking의 결과가 nil일 경우 ?? 연산자 다음에 나오는 값을 사용할 것.

```swift
var coalesce = (a ?? 0) + (b ?? 0)
```

**[Optional Unwrapping 2.forced-unwrapping]** 다음의 방법은 개발자가 무조건 값이 있다고 프로그램에게 알려주는 방법이다 ! 연산자를 이용한다.

```swift
var force_unwrap = a! + b!
```

**[Optional Unwrapping 3.if (var/let)]**

```swift
// if statements
if a != nil {
    print(a!)
}
```

if 문에 의한 Optional Type은 위와 같이 처리해줄 수 있다. 하지만 Type Checking을 실시해도 a는 Optional 변수이기 때문에 print(a) 로 실행시키면 “Optional(10)”로 출력이 진행된다. 그렇기 때문에 위에서 소개한 2가지의 방법으로 값을 unwrapping 해주어야 한다.

```swift
if let hasNumber = a {
    // 값이 있으면 a의 값을 받아와서 실행
    print(hasNumber)
}
if var hasNumber = a {
    // 값을 변경하고 싶을 때, 사용
    hasNumber = hasNumber * 2
    print(hasNumber)
}
```

Swift 에서는 위와 같이 if 구절에서 Optional을 검사 후, Optional 변수에 값이 있을 경우 변수에 대입하여 if block scope 안에서 해당 변수에 대한 처리를 사용한 Unwrapping 방식을 이용할 수 있다.

**[Optional Unwrapping 4.guard (var/let)]**

```swift
func testFunc(a: Int?) -> Int {\
    guard let hasNumber = a else {
				print("Has Not Number")
        return 0
    }

    return hasNumber * 10
}
print(testFunc(a:nil))
// Has Not Number
// 0
print(testFunc(a:10)) // 100

func testFunc2(_ a: Int?) -> Int {
    guard var hasNumber = a else {
        print("Has Not Number")
        return 0
    }
    hasNumber = hasNumber * 2
    return hasNumber
}
print(testFunc2(nil))
// Has Not Number
// 0
print(testFunc2(10))
// 20
```

Guard 문법은 오로지 함수안에서만 사용할 수 있는 unwrapping 방식이다. nil 감지시 함수를 종료시킬 수 있으며 unwrapping 시 guard (var/let)에 할당된 변수는 함수 스코프 안에서 유효하다.

# Operators

```swift
let a = 20
let b = 30

print(type(of: a)) // Int
print(type(of: b)) // Int

let d = a / b
print(type(of: d), d) // Int 0
```

**[Swift Has Not Auto Casting]** Swift 에는 Auto Casting, Force Casting과 같은 개념이 존재하지 않는다. 그렇기 때문에 위와 같은 Int와 Int의 연산에서는 Int 변수가 만들어지며 결과는 0이 된다.

```swift
let e = Double(a) / Double(b)
print(type(of: e), e) // Double 0.66666
```

또한 다른 자료형끼리의 연산은 허용하지 않기 때문에 이를 맞춰주어야 한다.

**[Remainder Operator]** % 연산자는 나머지를 구할 때 사용하는 연산자이다. 하지만 Swift에서 실수형은 % 연산자를 이용할 수 없다. 그래서 내장 함수인 truncatingRemainder 함수를 이용해야 한다.

```swift
let bbb: Double = 30.123
bbb.truncatingRemainder(dividingBy: 2) // 0.123
```

**[Unicode Definition]**

```swift
"\u{61}" // a
"\u{31}" // 1
"\u{1F495}" // 💕
```

# Unicode

| unicode             | character |
| ------------------- | --------- |
| "\u{30}" ~ "\u{39}” | 0~9       |
| "\u{61}” ~ "\u{7a}” | a~z       |
| "\u{41}” ~ "\u{5a}” | A~Z       |

```swift
if inputValue >= "\u{30}" && inputValue <= "\u{39}" {
    print("is Number")
} else {
    print("is not Number")
}

if (inputValue >= "\u{61}" && inputValue <= "\u{7a}") ||
    (inputValue >= "\u{41}" && inputValue <= "\u{5a}"){
    print("is English!")
} else {
    print("is not English")
}
```

# String

**[String Recurrent]** 대부분의 언어의 문자열은 문자 자료형 char의 배열로 이루어져 있다. Swift에서도 마찬가지로 for ch in str {} 구문을 통해 문자열에 문자들에 접근이 가능하다.

```swift
let myName = "hello, i am formegusto"

for character in myName {
    print(character)
}
```

**[String Operator]**

```swift
let hello = "hello, "
let intro = "i am formegusto"
let all = hello + intro

print(all) // hello, i am formegusto
```

**[Template String]** Javascript, Python에 있는 템플릿 문자열과 같다. 적혀있는 그대로 변수에 할당된다.

```swift
// 쓰는대로 나온다.
let myLongStr =
"""
hello,
    i am formegusto.
    my age is 26.
    yes yes funny programming
"""
print(myLongStr)
```

**[variable.description]** Javascript에서의 toString()이라고 생각하면 된다. 변수의 값을 문자열로 출력한다.

```swift
let isOn = false
print(isOn.description) // "false"
print(String(isOn)) // "false"
```

**[Template String = Template Literal]** Javascript와 마찬가지로 Swift에서의 템플릿 문자열은 표현식을 허용하는 문자열 리터럴 , 템플릿 리터럴이다. 다른 점은 백쿼터가 아닌 역슬래시와 괄호로 표현식을 정의한다.

```swift
let myNumber = 123
let introMyNumber = "my number is \(myNumber)"
```

**[built-in method]** 메서드의 결과로 만들어진 새로운 문자열을 반환한다.

```swift
print(introMyNumber.dropLast())
print(introMyNumber.dropFirst())
```

**[Split] 문자열에 이게 빠지면 섭하다.**

```swift
for splitCharacter in introMyNumber.split(separator: " ") {
    print(splitCharacter)
}
// my
// number
// is
// 123
```

# Collection Types

**[Array]** TypeSafe 한 특징을 가지고 있는 언어 답게, 배열 정의에 배열에 들어갈 변수들의 자료형을 등록해준다.

```swift
var myNames = Array<String>()
var myAges = [Int]()
```

**(Array append)**

```swift
// 한 개씩 추가
myNames.append("nth")
myNames.append("noth")
myNames.append("formegusto")
print(myNames)
// ["nth", "noth", "formegusto"]

myNames.append(contentsOf: ["no", "th"])
print(myNames)
// ["nth", "noth", "formegusto", "no", "th"]
myNames = myNames + ["kim", "lee", "park"]
print(myNames)
// ["nth", "noth", "formegusto", "no", "th", "kim", "lee", "park"]
```

**(Remove built-in method)**

```swift
// 첫 번째 요소 제거
myNames.removeFirst()
// ["noth", "formegusto", "no", "th", "kim", "lee", "park"]

// 마지막 요소 제거
myNames.removeLast()
// ["noth", "formegusto", "no", "th", "kim", "lee"]

// 특정 요소 제거
myNames.remove(at: 1)
// ["noth", "no", "th", "kim", "lee"]

// 모두 제거
myNames.removeAll()
// []
```

**(Empty Array Check)**

```swift
if myNames.count == 0 {}
if myNames.isEmpty {}
```

**(Insertion build-in method)**

```swift
myNames.insert("haha hello 0", at: 0)
myNames.insert("haha hello 2", at: 1)
myNames.insert("haha hello 1", at: 1)
// ["haha hello 0", "haha hello 1", "haha hello 2"]
// 같은 위치로 지정된 2와 1은 2가 먼저 삽입됐기 때문에 1이 삽입되면서 2가 뒤로 밀려났다.
```

**(enumerated)** welcome python! Set를 반환하며 첫 번째 대상체에는 idx, 두 번째 대상체에는 value가 입력되어 있다.

```swift
for (idx, value) in myNames.enumerated(){
    print(idx, value)
}
```

**[Set]** Array Type과 아주 유사하게 넣은 순서대로 들어간다. 하지만 중복을 허용하지 않으며 순서가 존재하지 않는 배열이다.

```swift
var names = Set<String>()
names.insert("no")
names.insert("th")
names.insert("formegusto")
// ["formegusto", "th", "no"]
```

**(Deduplication With Set)** Python과 마찬가지로 Set 변경 후, List로 변경하는 방식으로 중복을 제외시키기도 한다.

```swift
Array(Set(names))
```

**(Group Operator)** Set 타입은 집합 연산에 유리하다.

```swift
var numbers1: Set<Int> = [1,2,3,4,5]
var numbers2: Set<Int> = [4,5,6,7,8]

// 교집합
numbers1.intersection(numbers2)
// { 4, 5 }

// 합집합
numbers1.union(numbers2)
// { 1, 2, 3, 4, 5, 6, 7, 8 }

// 차집합 ( 합집합 후 중복을 배제 )
numbers1.symmetricDifference(numbers2)
// { 7, 3, 1, 2, 8, 6 }

// 여집합
numbers1.subtracting(numbers2)
// { 1, 2, 3 }
```

**[Dictionary] TypeScript 에서 객체의 key type을 설정해줄 때와 유사한 방식으로 선언한다.**

```swift
var namesOfStreet = [String: Any]()
namesOfStreet["302ro"] = "1st street"
namesOfStreet["303ro"] = "2nd street"
namesOfStreet["304ro"] = 3
namesOfStreet["305ro"] = nil
```

**(Dictionary Is Enumerable)** : Swift에서의 Dictionary 타입이 [String: Any]와 같이 하나의 배열로 구성이 될 수 있는 이유는 객체 타입의 문법으로 정의되는 타입이 아니기 때문이다. Swift에서의 Dictionary는 key와 value의 자료 형태가 늘어져 있다고 생각하면 된다. 이는 열거가 가능하다. 하지만 순서는 정해져있지 않다.

```swift
var namesOfStreet2: [String: Int] = ["a": 1, "b": 2, "e": 3]
print(namesOfStreet2)
print(namesOfStreet2.keys) // ["a", "b", "e"]
print(namesOfStreet2.values) // [1, 2, 3]
for dic in namesOfStreet2 {
    print(dic.key, dic.value)
}
```
