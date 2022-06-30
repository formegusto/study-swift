import UIKit

// Inheritance
// 상속 - class

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

class Guest: UserInfo {
    let place: String
    
    override init(_ name: String, _ age: Int) {
        self.place = "Jeju"
        
        super.init(name, age)
    }
    
    override func isAdult() -> Bool {
        if age > 25 {
            return true
        }
        return false
    }
    
    func compareParent() -> [String:Bool] {
        return ["parent":super.isAdult(),"me":self.isAdult()]
    }
}

let guest: Guest = Guest("forme", 23)
print(guest.name, guest.age) // forme 27
print(guest.isAdult()) // false
print(guest.compareParent()) // ["parent": true, "me": false]
