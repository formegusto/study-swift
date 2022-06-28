import UIKit

// protocol
// 규격, 규약, 규칙, 청사진, 뼈대
protocol UserInfo {
    var name: String { get set }
    var age: Int { get }
    static var UserCount: Int { get set }
    func isAdult() -> Bool
}
class Guest: UserInfo {
    var name: String = ""
    var age: Int
    static var UserCount: Int = 0
    
    init() {
        self.age = 0
        Guest.UserCount += 1
    }
    
    func isAdult() -> Bool {
        return true
    }
}

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
    func isAdult() -> Bool {
        if self.age > 25 {
            return true
        }
        return false
    }
}
print(AdultPerson().isAdult()) // false

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

protocol SomeProtocol {
    init()
    init(someParameter: Int)
    init(_ someParameter1: Int, _ someParameter2: Int)
}
//class SomeClass: SomeProtocol {
//    required init(someParameter: Int) {
//        print("required init")
//    }
//}
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
var car = Car(numberOfPassangers: 9)
car.go(to: "집")

protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
//struct Person: Named, Aged {
//    var name: String = "Aiden"
//    var age: Int = 27
//}

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
class Forme: Person {
    func notChoice() {
        print("non-name, non-speak")
    }
}

