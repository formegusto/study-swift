# Extension

## References

[Swift 문법, Extension 확장 역할 및 사용방법](https://0urtrees.tistory.com/137)

Swift의 확장(Extension) 기능은 1) 클래스, 2) 구조체, 3) 열거형, 4) 프로토콜 타입에 새롭게 기능적인 부분을 추가할 수 있는 문법이다. 이는 내가 정의한 1~4에 해당하는 것들 뿐만 아니라, 내부 소스에 있는 원본 타입들에 대해서도 새로운 기능을 부여할 수 있다.

**[ Extension Functions ]** 계산프로퍼티, 계산타입 프로퍼티 추가 기능 / 인스턴스 메서드, 타입 메서드의 정의 / 새로운 생성자(initializer)의 제공 / 첨자(subscripts) 접근 방식 정의 / 중첩타입(nested type)의 정의 및 사용 / 특정 프로토콜을 준수하는 현존 타입 정의

**[ Extension Basic ]** Extension 문법은 확장할 기능(메서드, 생성자, 첨자, 계산 프로퍼티)을 작성할 클래스, 구조체, 열거형, 프로토콜의 이름을 기입하면서 시작된다.

```swift
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
```

**[ Extension With iOS ]** extension문법을 iOS에서 활용할 수 있는 가장 큰 예는 아래와 같다. UIColor라는 UIKit 에서 제공해주는 클래스에 개발자 정의 색을 추가해놓을 수 있다.

```swift
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
```

두 번째에 쓰인 class var 변수 선언 문법은 타임 프로퍼티 문법이다. 하지만 이와 같이 사용할 경우 static하게 접근하기 때문에 self 문법을 사용할 수 없다.
