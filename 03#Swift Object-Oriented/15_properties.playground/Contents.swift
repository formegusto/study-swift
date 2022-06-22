import UIKit

// Stored Property
//class MyInfo {
//    var name = ""
//    var age = 0
//}

// Computed Property
//class MyInfo {
//    private var _email = ""
//    var email: String {
//        get {
//            return _email
//        } set {
//            self._email = newValue.hash.description
//        }
//    }
//    var isAdult: Bool {
//        if age > 19 {
//            return true
//        }
//        return false
//    }
//}
//var myInfo = MyInfo()
//myInfo.email = "formegusto"
//print(myInfo.email) // 3092686191984493653

// Lazy Stored Property
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
