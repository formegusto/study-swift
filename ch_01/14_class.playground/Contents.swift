// Class
class MyInfo {
    
    init(gender: GenderType) {
        self.genderType = gender
    }
    
    enum GenderType {
        case male
        case female
    }
    
//    var genderType: GenderType?
//    내부에서만 사용가능한 변수
//    private var genderType: GenderType = GenderType.male
    
    var genderType: GenderType = GenderType.male
    var name = ""
    var age = 0
    
    func isAdult() -> Bool {
        if age > 19 {
            return true
        }
        return false
    }
}

var myInfo = MyInfo(gender: .male)
print(myInfo.genderType, myInfo.name, myInfo.age, myInfo.isAdult())

// 클래스는 참조 타입이라 어디든지 연결되어 있다.
var myInfo2 = myInfo
myInfo2.age = 100
print(myInfo.age)

// 즉 이 두개는 같은 객체를 바라보고 있다.

// Class - Inheritance
// 상속
class GameInfo {
    private var name = ""
    var homeScore = 0
    var awayScore = 0
    
    init(_ name: String) {
        self.name = name
    }
    
    func presentScore() -> String {
        return name + "'s score" + homeScore.description + " : " + awayScore.description
    }
}

class Soccer: GameInfo {
    var time = 0
    init() {
        super.init("soccer")
    }
}

class BaseBall: GameInfo {
    var round = 0
    init() {
        super.init("baseball")
    }
    
    override func presentScore() -> String {
        return "아 야구 결과!! " + homeScore.description + " : " + awayScore.description
    }
}

let soccer = Soccer()
print(soccer.presentScore())

let baseball = BaseBall()
print(baseball.presentScore())
