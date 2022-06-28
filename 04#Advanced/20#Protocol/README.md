# Protocol

## References

[프로토콜 (Protocols)](https://jusung.gitbook.io/the-swift-language-guide/language-guide/21-protocols)

Swift protocol 문법은 특정 기능 수행에 필수적인 요수를 정의한 청사진, blueprint를 말한다. protocol을 만족시키는 타입을 protocol을 따른다고 말한다.

- Protocol 추상 인터페이스와 비슷한 격으로 생각하면 된다. Protocol 에 정의하고 제시한 변수, 메서드 등을 구조체, 클래스, 열거형에서 채택하여 완성본을 작성시킨다.
- Protocol 은 정의되어지면 하나의 타입으로 사용되기 때문에 1) 매개변수 타입 혹은 리턴 타입 2) 상수, 변수, 프로퍼티의 타입 3) 배열, 딕셔너리의 원소타입 으로 사용이 될 수 있다.

**[ Protocol Basic ]**

```swift
protocol UserInfo {
    var name: String { get set }
    var age: Int { get }
    static var UserCount: Int { get set }
    func isAdult() -> Bool
}
class Guest: UserInfo {
    var name: String = ""
    var age: Int {
        get {
            return self.age
        }
    }
    static var UserCount: Int = 0

    init() {
        Guest.UserCount += 1
    }

    func isAdult() -> Bool {
        return true
    }
}
```

protocol에서 protocol은 항상 var 문법으로 선언이 되어야 하며, 이름과 타입 gettable, settable의 여부를 명시해준다.

**[ Required Method ]** Protocol을 사용하는 대상체에서 정의되지 않아도 꼭 사용되어야 하는 메서드가 있는 경우에는 Extension 문법을 사용하여 메서드 확장을 해준다.

```swift
extension UserInfo {
    func isAdult() -> Bool {
        if age > 19 {
            return true
        }
        return false
    }
}
class AdultPerson: UserInfo {
    var name: String = ""
    var age: Int = 20

    static var UserCount: Int = 0
}
print(AdultPerson().isAdult()) // true
```

하지만 protocol의 기본적인 메서드가 구현부에서 구현이 완료된 경우에는 구현된 타겟의 메서드가 우선순위로 실행된다.

```swift
class AdultPerson: UserInfo {
    var name: String = ""
    var age: Int = 20

    static var UserCount: Int = 0
    func isAdult() -> Bool {
        if self.age > 25 {
            return true
        }
        return false
    }
}
print(AdultPerson().isAdult()) // false
```

**[ settable ]** protocol에 settable을 명시해주지 않으면 구현부에서 해당 프로퍼티를 let으로 선언할 수 없다.

```swift
protocol Dog {
    var sound: String { get set }
    var age: Int { get }
}
class Maltese: Dog {
    //  protocol requires property 'sound' with type 'String';
    // let sound: String
    var sound: String
    let age: Int

    init() {
        self.sound = "멍멍"
        self.age = 10
    }
}
```

**[ Initializer Requirements ]** protocol에서 initializer가 작성된 경우, 구현부에서 required 키워드를 꼭 붙여주어야 한다.

```swift
protocol SomeProtocol {
    init(someParameter: Int)
}
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        print("required init")
    }
}
```

만약에 protocol과 super class를 동시에 사용하는 경우에는 SubClass의 initializer 앞에 required 키워드와 override 키워드를 붙여줘야 한다.

```swift
protocol SomeProtocol {
    init()
    init(someParameter: Int)
    init(_ someParameter1: Int, _ someParameter2: Int)
}
class SomeSuperClass {
    init(someParameter: String) {}
    init(_ someParameter1: Int, _ someParameter2: Int) {}
}
class SomeSubClass: SomeSuperClass, SomeProtocol {
    // 1
    required init(){
        super.init(someParameter: "0")
    }
    required init(someParameter: Int) {
        super.init(someParameter: someParameter.description)
    }

    // 2
    override init(someParameter: String) {
        super.init(someParameter: someParameter)
    }

    // 3.
    required override init(_ someParameter1: Int, _ someParameter2: Int) {
        super.init(someParameter1, someParameter2)
    }
}
```

경우의 수는 여러개로 존재하지만, 클래스를 상속한 경우에는 super.init 으로 부모클래스의 생성자를 한번 호출해줘야 하는 것은 공통이다.

1. Protocol 에만 구현된 경우 : required 키워드 작성
2. Super Class 에만 구현된 경우 : overried 키워드 작성
3. Protocol, Super Class 모두 구현된 경우 : 요구하는 생성자 이기도 하고, 동시에 부모로부터 overriding 하는 것이기 때문에 required override 키워드를 작성해준다.

**[ Delegation ]** Delegation(위임) 은 GoF 디자인 패턴 중, 구조 패턴에 속하는 Composition Pattern을 상속으로부터 강하게 만드는 방법을 가리킨다. **인스턴스에게 특정 행위에 대한 책임을 넘기는 디자인 패턴 중 하나** 이다.

- Delegation된 기능을 제공할 수 있도록 Delegation된 **책임을 캡슐화하는 프로토콜을 정의**한다.
- Delegation은 특정 액션에 응답하거나 해당 소스의 기본 타입을 알 필요 없이 외부 소스에서 데이터를 검색하는데에 사용할 수 있다.

```swift
protocol DeliveryDataProtocol: AnyObject {
    func deliveryData(_ data: String)
}
```

protocol 문법에 AnyObject 혹은 class를 추가하면 클래스에서만 해당 프로토콜을 채택할 수 있는 Class-Only Protocol이 되어버린다.

```swift
class SecondView: UIViewController {
    weak var delegate: DeliveryDataProtocol?
		// ...
}

class ViewController: UIViewController, DeliveryDataProtocol {
		// ...

		@IBAction func nextButtonAction(_ sender: Any) {
        guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as? SecondView else {
            return
        }
        secondVC.delegate = self
        self.navigationController?.pushViewController(secondVC, animated: true)
    }

    func deliveryData(_ data: String) {
        dataLabel.isHidden = false
        dataLabel.text = data
    }
}
```

iOS에서 Delegation Protocol은 주로 ViewController간의 상호작용을 위해 쓰인다. 직접적으로 무언가 작업을 할 ViewController에게 Delegation Protocol을 상속받도록 하고, Protocol의 기능을 구현하도록 유도한다. 그리고 이어지는 다른 ViewController에서도 해당 delegate를 이용하여 Delegate Protocol을 상속받은 ViewController를 제어할 수 있게된다.

```swift
@IBAction func popAction(_ sender: Any) {
    let text = textField.text
    delegate?.deliveryData(text ?? "")
    self.navigationController?.popViewController(animated: true)
}
```

**[ Protocol Inheritance ]** 프로토콜도 상속 문법을 지원한다.

```swift
protocol Movable {
    func go(to destination: String)
}

protocol OnBoardable {
    var numberOfPassangers: Int { get }
}

protocol Vehicle: Movable, OnBoardable {}

struct Car: Vehicle {
    func go(to destination: String) {
        print("\(destination)(으)로 갑니다.")
    }
    var numberOfPassangers: Int = 4
}
```

이 때 해당 protocol은 typealias의 문법과 같다.

```swift
typealias Vehicle = Movable & OnBoardable
```

**[ Protocol Composition ]** 프로토콜은 동시에 여러개를 따르도록 선언할 수 있다.

```swift
struct Person: Named, Aged {
    var name: String = "Aiden"
    var age: Int = 27
}
```

**[ Protocol Type Checking ]** 일반적인 타입 확인과 마찬가지로 is, as 문법을 사용한다.

- is : 앞에 있는 타입이 뒤에있는 프로토콜을 채택하고 있는 지 확인 ( Return Type Bool )
- as? : 앞에 있는 타입이 뒤에있는 프로토콜을 채택하고 있는 경우 해당 타입을 다운 캐스트, 그렇지 않은 경우에는 nil 반환
- as! : 앞에 있는 타입을 뒤에 있는 프로토콜 타입으로 다운캐스트 실패시 런타임 에러 발생

**[ Optional Protocol Requirements ]** 프로토콜을 선언하면서 필수 구현이 아닌 선택적 구현 조건을 정의할 수 있다.

```swift
@objc protocol Person {
    @objc optional var name: String { get }
    @objc optional func speak()
}
class Forme: Person {
    func notChoice() {
        print("non-name, non-speak")
    }
}
```

@objc 프로토콜은 클래스만 채택할 수 있다. 그리고 한 가지 단점으로는 사용자가 정의한 struct, enum과 같은 타입을 사용할 수 없다는 것 이다. 이를 해결하기 위해서는 NSObject를 상속받아야 하는데 이렇게 작성하게 될 경우에는 class 문법으로 작성해주어야 한다.

```swift
//struct CustomType {
//    var property: String = "특수타입"
//}
// note: Swift structs cannot be represented in Objective-C

class CustomType:NSObject {
    var property: String = "특수타입"
}
@objc protocol Person {
    @objc optional var name: CustomType { get }
    @objc optional func speak()
}
```
