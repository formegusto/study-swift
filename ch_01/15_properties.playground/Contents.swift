import UIKit

// Properties
// 프로퍼티
class MyInfo {
    
    // stored property (저장)
    var name = ""
    var age = 0
    
    // lazy stored property
    // 이런경우, 클래스가 인스턴스화되는 시점에 많이 버벅거리게 된다.
    // 처음부터 띄울 필요가 없다고 친다면 앞에 lazy 키워드를 쓴다.
    // 사용하는 순간에 가지고 온다.
    lazy var myProfiles = [UIImage(named: "n"), UIImage(named: "a"),UIImage(named: "c"),UIImage(named: "d"),UIImage(named: "a")]
    
    // computed property (계산)
    // 해당 모양은 함수가 아닌, computed property
    var isAdult: Bool {
        if age > 19 {
            return true
        }
        return false
    }
    
    // computed property 응용
    // email -> 보안 -> 암호화 된 값으로 사용한다. (항상)
    private var _email = ""
    var email: String {
        // set은 생략이 되지만, get은 생략이 되지 않는다.
        // 그래서 isAdult가 get 형식이 가능한 것!
        get {
            // 리턴값
            return _email
        } set {
            // 저장해야되는 값
            _email = newValue.hash.description
        }
    }
}

let myInfo = MyInfo()
myInfo.age = 10
myInfo.name = "kim"
myInfo.email = "formegusto@github.com"

// 이 시점에 가지고 온다
myInfo.myProfiles

print(myInfo.age)
print(myInfo.isAdult)
print(myInfo.email)
// Error 발생
// myInfo.isAdult = true
