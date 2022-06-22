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

var myInfo2 = myInfo
myInfo2.age = 20
myInfo.showIsAdult() // 성인입니다.

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

//
//// Class - Inheritance
//// 상속
//class GameInfo {
//    private var name = ""
//    var homeScore = 0
//    var awayScore = 0
//
//    init(_ name: String) {
//        self.name = name
//    }
//
//    func presentScore() -> String {
//        return name + "'s score" + homeScore.description + " : " + awayScore.description
//    }
//}
//
//class Soccer: GameInfo {
//    var time = 0
//    init() {
//        super.init("soccer")
//    }
//}
//
//class BaseBall: GameInfo {
//    var round = 0
//    init() {
//        super.init("baseball")
//    }
//
//    override func presentScore() -> String {
//        return "아 야구 결과!! " + homeScore.description + " : " + awayScore.description
//    }
//}
//
//let soccer = Soccer()
//print(soccer.presentScore())
//
//let baseball = BaseBall()
//print(baseball.presentScore())
