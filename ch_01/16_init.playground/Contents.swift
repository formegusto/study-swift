import UIKit

// Initializer
// 생성자

class MyInfo {
    var name: String
    var myId: String
    
    var age: Int? = 0
    var isAdult: Bool
    
    // 초기화를 안해주면, 후에 생성자에서 꼭 초기화해주어야 한다.
//    init() {
//        self.name = ""
//        self.myId = ""
//        self.isAdult = (age > 19) ? true : false
//    }
    
    init(n: String, id: String) {
        self.name = n
        self.myId = id
        self.isAdult = ((age ?? 0) > 19) ? true : false
    }
    
//    init(id: String) {
//        self.name = ""
//        self.myId = id
//        self.isAdult = (age > 19) ? true : false
//    }
//
    // convenicence initializer // 필수 조건 - 다른 Init을 반드시 실행
    convenience init() {
        self.init(n: "", id: "")
    }
    
    convenience init(id: String) {
        self.init(n: "", id: id)
    }
}

//var myInfo1 = MyInfo.init(n: "no", id: "formegusto")
var myInfo1 = MyInfo(n: "no", id: "formegusto")
var myInfo2 = MyInfo()
var myInfo3 = MyInfo(id: "formegusto")

myInfo1.name
myInfo1.myId
