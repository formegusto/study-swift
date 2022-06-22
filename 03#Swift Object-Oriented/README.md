# 03#Swift Object-Oriented

# enum

어느 프로그래밍 언어에서든지 공통 의미이다. 사용자 정의 변수를 설정할 수 있다.

```swift
enum BookType {
    case fiction
    case comics
    case workbook
}
var bookStyle: BookType = BookType.fiction
var books = [BookType]([BookType.fiction, BookType.comics])

print(bookStyle) // comics
for book in books {
    print(book)
}
/*
 fiction
 comics
 */
```

**[Simple Usage]** Swift의 enum타입으로 정의되어 있는 모든 것들은 정의한 enum 자료형을 생략하고{.Value}의 형식으로 표현할 수 있다.

```swift
var books = [BookType]()
let saveBook: (BookType) -> Void = { books.append($0) }
let readBooks: () -> Void = {
    for book in books {
        print(book)
    }
}
saveBook(BookType.workbook)
saveBook(.comics)
books.append(.fiction)

readBooks()
/*
 workbook
 comics
 fiction
 */
```

**[Classification + Value]**

```swift
enum BookValueType {
    case fiction(title: String, price: Int, year: Int)
    case comics(title: String, price: Int, year: Int)
    case workbook(title: String, price: Int, year: Int)
}
var bookValue: BookValueType = .comics(title: "안녕", price: 2000, year: 2010)
if case let .comics(title, price, year) = bookValue {
    print(title)
}
```

```swift
var bookValues = [BookValueType]()
func saveBookValue(_ book: BookValueType) {
    bookValues.append(book)
}
saveBookValue(.comics(title: "재밌는 1", price:2000, year: 2012))
saveBookValue(.fiction(title: "재밌는 2", price: 3000, year: 2020))
saveBookValue(.workbook(title: "재밌는 3", price: 4000, year: 2022))

for bookValue in bookValues {
    switch bookValue {
        case let .comics(title, price, year):
            print("comics", title, price)
        case let .fiction(title, price, year):
            print("comics", title, price)
        case let .workbook(title, price, year):
            print("comics", title, price)
    }
}
```

Swift 에서의 enum은 Tuple 형식의 데이터 삽입을 지원하고 있다. 이 때 조회 방법으로는 if case let 구문을 사용한다.

**[Extension with enum.self]**

```swift
extension BookValueType {
		// 해당 구문은 변수에 값을 넣을 때, 특정 구문을 실행시킨 다음에 넣을 수 있는 구문이다.
    var typeName: String {
        switch self {
            case .comics:
                return "comic"
            case .fiction:
                return "fiction"
            case .workbook:
                return "workbook"
        }
    }
}
if case let .comics(title, price, year) = bookValues[0] {
    print(bookValues[0].typeName, title, price, year) // comic 재밌는 1 2000 2012
}
```

Swift에서의 enum은 단순히 사용자 정의 자료형의 역할만을 하지 않는다. self가 있다. 객체로서 생성이 된다는 의미이다. 그렇기 때문에 extension과 self를 통하여 확장을 진행할 수 있다.

# Class

```swift
class MyInfo {
    enum GenderType {
        case male
        case female
    }

    var options: String?
    var gender: GenderType
    var name = ""
    var age = 0
    private var isAdult = false

    init(gender: GenderType) {
        self.gender = gender
    }

    func showIsAdult() -> Void {
        if age > 19 {
            print("성인 입니다.")
            return
        }
        print("어린이 입니다.")
    }
}
var myInfo = MyInfo(gender: .male)
print(myInfo.gender, myInfo.name, myInfo.age)
myInfo.showIsAdult()
```

우리가 알고있는 클래스 정의방식과 사용방식이다. Python에서의 초기화 함수인 init, this가 아닌 self를 이용하고, Swift만의 고유 enum 할당 방식 등이 이용된다.

```swift
var myInfo2 = myInfo
myInfo2.age = 20
myInfo.showIsAdult() // 성인입니다.
```

Swift에서의 객체도 Reference Type 이기 때문에 다른 변수에 할당하면 똑같은 객체를 바라보고 동작한다.

**[Inheritance]** Swift에서의 상속은 콜론(:)을 사용하여 진행된다.

```swift
class GameInfo {
    private var name = ""
    var homeScore = 0
    var awayScore = 0

    init(_ name: String) {
        self.name = name
    }

    func presentScore() -> String {
        return name + "'s score - " + homeScore.description + " : " + awayScore.description
    }
}

class Soccer: GameInfo {
    var time = 0

    init() {
        super.init("soccer")
    }
}

class BaseBall: GameInfo {
    var time = 0

    init() {
        super.init("baseball")
    }

    override func presentScore() -> String {
        return "야구결과는 한국어로 진행됩니다.\n" + super.presentScore()
    }
}

let soccer = Soccer()
print(soccer.presentScore())
// soccer's score - 0 : 0

let baseball = BaseBall()
print(baseball.presentScore())
/*
 야구결과는 한국어로 진행됩니다.
 baseball's score - 0 : 0
 */
```

**[Properties]** Swift의 Class는 여러가지 형태의 property를 지원해준다.

**Stored Property** - 가장 일반적인 형태의 property

```swift
class MyInfo {
    var name = ""
    var age = 0
}
```

**Computed Property** - Javascript에서의 접근자 메서드 개념이 붙어 있는 property

```swift
class MyInfo {
    private var _email = ""
    var email: String {
        get {
            return _email
        } set {
            self._email = newValue.hash.description
        }
    }
    var isAdult: Bool {
        if age > 19 {
            return true
        }
        return false
    }
}
var myInfo = MyInfo()
myInfo.email = "formegusto"
print(myInfo.email) // 3092686191984493653
```

자동으로 newValue라는 변수에 개발자가 대입 연산식에 사용하는 값이 매핑된다. 위와 같이 외부에서 접근 못하는 Private Property를 정의한 후에 Computed Property를 통하여 특정 동작을 진행한 값으로 입력 및 출력하는 경우에 사용된다. set은 생략이 가능하며, get은 생략할 수 없다. 그래서 get만 존재하는 경우 축약형태로 표현되도록 할 수 있다.

**Lazy Stored Property** - 접근하는 순간에 초기화되는 property

```swift
class MyInfo {
    lazy var myProfiles = [UIImage(named: "n"),
                           UIImage(named: "a"),
                           UIImage(named: "c"),
                           UIImage(named: "d"),
                           UIImage(named: "a"),
                           UIImage(named: "e")]
}
var myInfo = MyInfo()
myInfo.myProfiles
```

위와 같이 많은 Image를 가지고 와야하는 객체의 경우 객체화되는 과정에서 성능저하가 발생할 수 있다. 그래서 객체 초기화 때에 가지고 오지 않고, myInfo.myProfiles와 같이 객체 안에 property를 조회하는 순간에 해당 property 내용을 초기화한다.

**[Init]** Swift Class에 Optional Type이 아닌 모든 Property 즉시 초기화 혹은 init() 메서드 안에서 초기화를 진행시켜주어야 한다.

```swift
class MyInfo {
    var name: String;
    // note: stored property 'name' without initial value prevents synthesized initializers
}
```

**[convenience init]** 오버로딩으로 생성자 함수를 구성해도 되지만, Swift에는 convenience init 이라는 생성자 함수를 명시적으로 재 사용할 수 있는 문법을 제공해준다.

```swift
class MyInfo {
    var name: String;
    var age: Int;

    init(_ name: String, _ age: Int) {
        self.name = name
        self.age = age
    }

    convenience init() {
        self.init("", 20)
    }

    convenience init(_ name: String) {
        self.init(name, 20)
    }
}

var myInfo1 = MyInfo()
print(myInfo1.name, myInfo1.age) // "" 20
var myInfo2 = MyInfo("formegusto")
print(myInfo2.name, myInfo2.age) // formegusto 20
```

**[ARC : Automatic Reference Counting]** - Swift는 메모리 관리를 Java나 C#의 Garbage Collector가 아닌 Rust와 같은 언어에서 사용하는 ARC, Automatic Reference Counting을 이용한다. Garbage Collector는 Run Time 시점에 객체를 참조하여 동적으로 힙에 있는 객체를 해제하는 기술인데 Automatic Reference Counting은 **Compile Time 시점에 객체를 참조하여 객체가 참조될 경우 Count를 1 증가시키고, 반대로 참조 해제되어 Count가 0이 되면 메모리에서 객체를 해제하는 기술**이다.

**[deinit]** Swift에는 ARC가 객체를 해제하는 시점에 특정 동작을 실행시킬 수 있는 메서드가 존재한다.

```swift
class Round {
    var lastRound = 10
    var roundTime = 20

    init() {
        print("round init")
    }

    deinit {
        print("round deinit")
    }
}

var round: Round? = Round() // round init
var round_copy: Round? = round
round = nil
round_copy = nil // round deinit
```

**[weak]** ARC의 단점은 개발자가 메모리에 대한 구조를 이해하고 있어야 한다는 점 이다. 실수할 경우 개발자의 실수에 의하여 순환참조를 발생시킬 수 있다. 이로 인해 memory leak (메모리 누수)가 발생할 수 있다.

```swift
// 순환참조의 예시
class Car {
    var driver: Human?

    deinit {
        print("Car is deinit")
    }
}

class Human {
    var ownCar: Car?

    deinit {
        print("Human is deinit")
    }
}

var car: Car? = Car()
var tom: Human? = Human()

car?.driver = tom
tom?.ownCar = car

car = nil
tom = nil
```

현재 상태에서 var car에 생성된 인스턴스를 참조하고 있는 변수는 2개이다. (car, tom.ownCar) 이러한 상황에서 ARC는 해당 인스턴스의 Count를 2로 해놨을텐데 tom에 nil을 대입해버리면 ownCar로 접근할 수 없게된다. 여기서 car를 nil로 설정해도 Count는 여전히 1로 생성된 인스턴스는 여전히 메모리에 남아있다.

```swift
var round: Round? = Round()
weak var round_copy: Round? = round
round = nil
print(round_copy) // nil
```

이를 위해 Swift에서는 weak 문법을 제공한다. weak 문법으로 생성된 변수는 Round 객체보다는 Round를 참조하고 있는 변수에 관심을 가진다. 해당 변수가 Round 참조를 해제하면 weak 변수도 참조를 해제한다.

# Struct

Class를 여러 변수로 구성되어 하나의 형태를 이루고, 기능을 수행할 수 있는 객체를 찍어내는 Factory라고 생각한다면 Struct도 같은 개념이다 Class의 개념에서 상속이 빠졌을 뿐 이다. 그리고 대입연산자에서 수행하는 역할이 다르다.

```swift
struct ImageType {
    var type = ""
}

var imageType1 = ImageType()
var imageType2 = imageType1

imageType1.type = "jpg"
imageType2.type = "png"

print(imageType1.type) // jpg
print(imageType2.type) // png
```

Class로 만들어진 객체는 다른 변수에 대입하면 참조의 개념으로 대입이 되었다. 하지만 구조체로 만들어진 객체는 다른 변수에 대입하면 Copy의 개념으로 대입연산이 이루어진다.
