import UIKit

// protocol
// 규격, 규약, 규칙, 청사진, 뼈대

// get set 이 설정되어 있어야 한다.
// set 은 굳이 안 써도된다.
// 약간 타입스크립트에 타입 정의라고 생각하면 될 거 같다.
protocol UserInfo {
    var name: String { get set }
    var age: Int { get set }
    func isAdult() -> Bool
}

// protocol 에서 꼭 사용해야하는 기능이 있는 경우, is Adult
extension UserInfo {
    func isAdult() -> Bool {
        if age > 19 {
            return true
        }
        return false
    }
}

class Guest: UserInfo {
    var name: String = ""
    var age: Int = 0
//    func isAdult() -> Bool {
//        if age > 19 {
//            return true
//        }
//        return false
//    }
}

class Member: UserInfo {
    var name: String
    var age: Int
    
//    func isAdult() -> Bool {
//        if age > 19 {
//            return true
//        }
//        return false
//    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

// protocol은 이렇듯 초기에 구현해야하는 로직을 구현하게 만들 수 있다.
class UserInfoPresenter {
    func present() {
        let guest = Guest()
        let member = Member(name: "no", age: 26)
        
//        let members = [guest, member] Error!
        let members: [UserInfo] = [guest, member]
        for mem in members {
            print(mem.name)
        }
    }
}
let presenter = UserInfoPresenter()
presenter.present()

// set은 상속에 오는 클래스가 var 혹은 let을 허용하는 개념이다.
protocol UserInfo2 {
    var name: String { get set }
    var age: Int { get }
}
class Member2: UserInfo2 {
    var name: String = ""
    let age: Int = 10
}
// set이 빠질 경우, class에 상수 let을 주어, 처음 초기에만 설정 가능하도록 설정할 수 있다.

//protocol UserInfo3 {
//    var name: String { get set }
//    var age: Int { get set }
//}
//class Member3: UserInfo3 {
//    var name: String = ""
//    let age: Int = 10
//}
// 해당 상황은 protocol에서 set을 설정했으므로 상수를 쓸 수 없는 케이스이다.

// (+) 클래스에서 isAdult 같은 extension에 구현이 되어 있는 함수를 구현하면 해당 클래스의 isAdult가 우선순위로 실행된다.

// 또한 다중 상속 가능
protocol Score {
    var score:Int { get set }
}
class Student: UserInfo, Score {
    var score: Int = 100
    
    var name: String = ""
    var age: Int = 10
}
