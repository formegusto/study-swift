import UIKit

// Structure
// 구조체

// 클래스와의 차이점은, 클래스는 인스턴스화해서 사용하지만,
// 구조체는 그런느낌이 아니다. 하나의 값이된다고 생각하면 된다.
// 상속도 안됨 ( 이게 가장 큰 특징이다. 다른쪽과 연결될 필요가 없다면,
// 굳이 클래스를 사용하지 않아도 된다. )
struct ImageType {
    var type = ""
}

var imageType1 = ImageType()
var imageType2 = imageType1 // 고대로 복사된다. 참조의 개념이 아님
var imageType3 = imageType2


imageType1.type = "jpg"
imageType2.type = "png"

imageType1.type
imageType2.type
