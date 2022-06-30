# Swift

# 👋 Hello Swift

[Swift - Apple Developer](https://developer.apple.com/kr/swift/)

## Modern

Swift는 Apple에서 내놓은 프로그래밍 언어이다. Apple 플랫폼 구축 경험이 결합되어 있는 언어로 소개되어 있다. 본문은 해당 Repository에 정리한 Swift 기초문법 공부를 끝낸 후에 공식 소개 페이지를 보며 작성하고 있는데, 공부하면서 느낀점은 각 종 언어들의 트렌드한 장점들(TypeSafe, Non-Semicolon, first-class object,,,) 을 끌어모아서 만들어 낸 느낌이 컸다. 이렇게 만들어진 Swift는 재미있고, 사용하기 쉬운 언어라고 자신을 소개하고 있다.

## Designed for safety

Swift의 TypeSafe는 사용해보니 정말 강력하다. 빈틈이 없다는 것을 느꼈다. 이러한 특징은 Swift의 안전 중심의 설계는 불안전한 코드를 방지할 수 있다. 1) 변수는 사용 전에 항상 초기화, 2) 배열 및 정수에 대한 오버플로우 검사 3) 메모리는 자동 관리 와 같은 특징을 가진다. 여기서 Optional Type(nil값 존재여부), weak(메모리 누수 방지)와 같은 Syntax를 통하여 사용자의 의도를 쉽게 알 수 있도록 조정한다.

## Fast and powerful

Swift는 최초 개념 설정 시점부터 빠르게 동작함을 목표로 두었고, 고성능 LLVM(Low Level Virtual Machine) 컴파일러 기술을 사용하여 최신 하드웨어를 최대한 활용할 수 있도록 최적화된 코드로 변환시키는 기술을 사용했다. 그게 우리가 들고 있는 iPhone, Mac, AppleWatch 그 어떤 기계가 됐든지 말이다.

LLVM을 사용하는 언어로는 C, C++, Object-C 등이 있다. Swift는 이들의 후속 언어로, 유형, 흐름제어, 연산자와 같은 하위 수준 Primitive는 물론이고, Class, Protocol, Generic과 같은 Object-Oriented 기능을 제공한다.

**LLVM(Low Level Virtual Machine)** - 컴파일러 기반구조를 말한다. 프로그램을 컴파일 타임, 링크 타임, 런타임 상황에서 프로그램의 작성 언어에 상관없이 최적화를 쉽게 구현할 수 있도록 구성되어 있다.

## Open Source

Swift는 [Swift.org](http://Swift.org) 에서 오픈소스로 개발되었다. 모든 사람들이 이용할 수 있는 Community로 부터 개방하면서 시작했기 때문에 Apple 뿐만 아니라 수백 명의 외부 개발자가 참여하는 광범위한 개발자 커뮤니티에서 Swift를 더욱 멋진 언어로 만들기 위해 협력하고 있다고 한다.

**[ Cross Platform ]** Linux를 비롯한 모든 Apple Platform을 지원한다. (Window는요,,?)

**[ Swift for Server ]** Swift는 Server Application으로써도 사용이 된다고 한다. 1) 런타임 안정성, 2) 컴파일된 성능 및 소규모 메모리 공간 과 같은 특징이 Server로 사용하기에도 적합함을 나타낸다. 이렇게 태어난 것이 SwiftNIO라고 한다,, 흠,,?

## Package Manager

Swift Package Manager는 Swift 라이브러리 및 실행 파일을 구축, 실행, 테스트 및 패키징하기 위한 단일 크로스 플랫폼이다. Swift 패키지를 Swift Community에 배포할 수 있다.

## Objective-C interoperability

동일한 프로젝트에서 기존 Objective-C 파일과 함께 Swift 코드가 공존할 수 있다. Objective-C API에 대한 완전한 접근 권한이 제공된다.
