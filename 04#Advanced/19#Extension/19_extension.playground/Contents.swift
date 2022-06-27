import UIKit

extension Int {
    var oddOrEven: String {
        if self % 2 == 0 {
            return "짝수"
        }
        return "홀수"
    }
    func factor() -> Int {
        return self * self
    }
}
print(3.oddOrEven) // 홀수
for _num in 1...3 {
    let target_num = _num * 2
    print(target_num, target_num.factor())
}
/*
 2 4
 4 16
 6 36
 */

extension UIColor {
    var mainColor1: UIColor {
        return UIColor(red: 50/255, green: 70/255, blue: 120/255, alpha: 1)
    }
    class var mainColor2: UIColor {
        return UIColor(red: 50/255, green: 70/255, blue: 120/255, alpha: 1)
    }
}
print(UIColor().mainColor1)
print(UIColor.mainColor2)

//// Extension
//// 기능 확장
//// struct, class, enum, protocol
//// 특정 기능이 계속 나와야 한다는 개념이다.
//
//// 숫자 (int) 짝수, 홀수 구분해야하는 것을 확장하고 싶은 경우
//extension Int {
//    var oddOrEven: String {
//        if self % 2 == 0 {
//            return "짝수"
//        }
//        return "홀수"
//    }
//}
//
//print(3.oddOrEven)
//print(2.oddOrEven)
//
//// UI Color
//// mainColor1 = xxx
//// mainColor2 = xxx
//// subColor2 = xxx
//
//// 원래는 이렇게 쓰는데 번거로우니까
//UIColor(red: 50/255, green: 70/255, blue: 120/255, alpha: 1)
//// 이렇게 적용해놓으면 UI에 색변수들을 잘 정리할 수 있고,
//// 어디서든 빼서 사용할 수 있다.
//extension UIColor {
//    var mainColor1: UIColor {
//        return UIColor(red: 50/255, green: 70/255, blue: 120/255, alpha: 1)
//    }
//}
//var button = UIButton()
//button.titleLabel?.textColor = UIColor().mainColor1
//
//// Type Property
//UIColor.orange
//// open class var orange: UIColor { get } // 1.0, 0.5, 0.0 RGB
//// 이는 인스턴스화 하지 않아도 꺼내 쓸 수 있다.
//// 하지만 extension은 인스턴스화해서 꺼내 써야 함.
//// 그래서 보통 아래와 같이 타임 프로퍼티를 사용해서 확장한다.
//extension UIColor {
//    class var mainColor2: UIColor {
//        return UIColor(red: 50/255, green: 70/255, blue: 120/255, alpha: 1)
//    }
//}
//UIColor.mainColor2
//// 대신 이는 당연하지만, self로 접근이 안된다.
