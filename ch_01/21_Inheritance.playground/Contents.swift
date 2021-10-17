import UIKit

// Inheritance
// 상속 - class

// protocol
class UserInfo {
    var name: String = ""
    var age: Int = 0
    func isAdult() -> Bool {
        if age > 19 {
            return true
        }
        return false
    }
}

class Guest: UserInfo {
    override func isAdult() -> Bool {
        return true
    }
    
    func present() {
        print(name)
        print(age)
        print(isAdult())
        
        // super로 부모클래스에 접근이 가능하다.
        print(super.isAdult())
    }
}

let guest = Guest()
guest.present()
