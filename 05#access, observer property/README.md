# 05#access, observer property

## References

[프로퍼티 get, set, didSet, willSet in iOS](https://medium.com/ios-development-with-swift/%ED%94%84%EB%A1%9C%ED%8D%BC%ED%8B%B0-get-set-didset-willset-in-ios-a8f2d4da5514)

## Access Property, get, set

**[ 기본 문법 ]**

```swift
var ap: String {
    get {
        return self.ap
    }
    set(newValue) {
        self.ap = newValue
    }
}
```

access property는 변수명 이후에 대괄호를 쳐서, 안에다가 get과 set을 기입한다. 하지만 위와 같은 경우 순환 참조 (Circular Reference)가 일어나기 때문에 잘못된 사용법이다.

```swift
var _ap: String  = ""
var ap: String {
    get {
        return self._ap
    }
    set(newValue) {
        self._ap = newValue
    }
}
```

보통 access property는 backing storage를 두고 사용한다. 이러한 access property의 사용법을 보면 access property는 다음과 같은 상황에서 사용될 수 있다는 것을 알 수 있다.

1. property에 적절한 값이 입력되는지 검증하기 위하여 사용 (Validation)

   ```swift
   var ap: String {
       get {
           return self._ap
       }
       set(newValue) {
           if newValue.contains(where: { Character in Character == "1"}) {
               self.apLabel.text = "1이 포함된 문자열은 저장할 수 없습니다."
               self._ap = ""
           } else {
               self.apLabel.text = "변수 _a 수정 중입니다."
               self._ap = newValue
           }
       }
   }
   ```

2. 다른 프로퍼티값에 의해 계산되어야 하는 프로퍼티인 경우 (Computed)

   ```swift
   var apLength: Int {
       get {
           return self._ap.count
       }
   }
   ```

3. Property를 Private하게 사용하기 위하여 (Information Hiding)

   ```swift
   private(set) var ap: String
   ```

   접근자 property가 다음과 같이 선언된 경우, internal getter와 private setter를 얻게된다. 즉, 하나의 클래스 안에서만 해당 값을 통하여 \_ap를 수정할 수 있다.

   ```swift
   public private(set) var ap: String
   ```

   다음과 같은 경우에는 public getter와 private setter를 얻게된다.

## Observer Property didSet, willSet

```swift
var op: String = "" {
    willSet(newValue) { }
    didSet(oldValue) { }
}
```

Swift 에서 제공해주는 observer property인 1) willSet은 변수의 값이 변하기 전에 호출된다. 그렇기 때문에 인자값으로 변화될 값인 newValue가 보내진다. 2) didSet은 변수의 값이 변한 후에 호출된다. 그렇기 때문에 인자값으로 변화되기 전에 값인 oldValue가 보내진다.

Observer Property를 사용하는 곳은 주로 View와 관련이 깊다. Observer Property가 변화할 때 마다 아래와 같이 접근시킬 수 있다.

```swift
var op: String = "" {
    willSet(newValue) { }
    didSet(oldValue) {
			self.label.text = self.op
		}
}
```

예로들어 해당 label이 여러 view에 의해 반응된다면, 우리는 Action 함수에 self.label.text = self.op 를 계속해서 기입해주어야 한다. 하지만 observer property를 사용하게 되면 변수의 변경에 반응하게 됨으로 기입할 필요가 없어지게 된다.
