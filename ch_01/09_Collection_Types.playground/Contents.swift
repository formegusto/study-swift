import UIKit

// Collection Types
// 집합 타입

// Array
// Swift - type safe
// 두 가지 방법으로 Collection 정의 가능
var myNames = Array<String>()
var myAges = [Int]()

myNames.append("nth")
myNames.append("noth")
myNames.append("formegusto")
print(myNames)
// 인덱스를 사용할때는 방어코드를 이용한다.
// 안전한 코딩 스타일 Array Outbounds를 방지한다.

var idx = 3
if myNames.count > idx {
    myNames[idx]
}
myNames.append(contentsOf: ["no", "th"])
print(myNames)

myNames = myNames + ["kim", "lee", "park"]
print(myNames)

// Array 에서 요소 삭제하기
print("before remove", myNames)
myNames.removeFirst()
print("after remove first", myNames)
myNames.removeLast()
print("after remove last", myNames)
myNames.remove(at: 1)
print("after remove [1]", myNames)
myNames.removeAll()
print("after remove all", myNames)

// 빈 Array 체크
if myNames.count == 0 {
    print("이렇게도")
}
if myNames.isEmpty {
    print("이렇게도 가능")
}

// 중간에 추가
myNames.insert("haha hello 0", at: 0)
myNames.insert("haha hello 2", at: 1)
myNames.insert("haha hello 1", at: 1)
print(myNames)

// 파이썬의 enumerate 함수
for (idx, value) in myNames.enumerated(){
    print(idx, value)
}

// Set
// Array와의 유사성. 넣은대로 순서대로 들어간다.
// 다른점. 순서가 존재하지 않는다. (인덱스의 개념이 없다.)
var names = Set<String>()
names.insert("no")
names.insert("th")
names.insert("formegusto")
names

// 같은 값은 중첩되지 않는다.
names.insert("th")
names

// 으으;; 거진 파이썬 Set으로 Array를 변환해주면 중복값을 제거할 수 있다.
names = ["no", "no", "non", "nonono", "non"]
print(names)
print(Array(Set(names)))

var names2: Set = ["no", "no", "test", "test2"]
print(names2)

// Set은 파이썬에서 수학적 집합 연산에 유용하다고 배웠다.
var numbers1: Set = [1,2,3,4,5]
var numbers2: Set = [4,5,6,7,8]

// 교집합
numbers1.intersection(numbers2)

// 합집합
numbers1.union(numbers2)

// 차집합
numbers1.symmetricDifference(numbers2)

// 여집합
numbers1.subtracting(numbers2)

// 집합의 예는 일정어플을 예로 들 수 있다.
// 일정이 2개인 날짜
numbers1.intersection(numbers2)
// 와 같은 식으로 뽑아낼 수 있을 것 이다.
// 혹은 문자열을 걸러낼때도 사용하기도 한다.

// Dictionary
// Key: Value 의 구성
var namesOfStreet = [String: Any]()
namesOfStreet["302ro"] = "1st street"
namesOfStreet["303ro"] = "2nd street"
namesOfStreet["304ro"] = 3
namesOfStreet["305ro"] = nil

print(namesOfStreet)
// 주의해야할 점은 Dictionary Type은 Value가 Any가 아닌,
// 다른 타입으로 지정되어 있어도 nil이 항상 존재할 수 있다는 점이다.
// Key에 맞는 Value가 없을때, 에러가 아닌, nil 값을 뽑아내기 때문이다.

var namesOfStreet2 = ["a": 1, "b": 2, "e": 3]
print(namesOfStreet2)
print(namesOfStreet2.keys)
print(namesOfStreet2.values)
for dic in namesOfStreet2 {
    print(dic.key, dic.value)
}
