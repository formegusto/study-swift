import UIKit

// String Recurrent
let myName = "hello, i am formegusto"

for character in myName {
    print(character)
}

// String Operator
let hello = "hello, "
let intro = "i am formegusto"
let all = hello + intro

print(all)

// Python의 문법과 같은데,
// 쓰는대로 나온다.
let myLongStr =
"""
hello,
    i am formegusto.
    my age is 26.
    yes yes funny programming
"""
print(myLongStr)

// JavaScript의 toString() 같은 효과 == description
let isOn = false
print(isOn.description)
print(String(isOn))

// Template
let myNumber = 123
let introMyNumber = "my number is \(myNumber)"
print(introMyNumber.dropLast())
print(introMyNumber.dropFirst())

// Split
for splitCharacter in introMyNumber.split(separator: " ") {
    print(splitCharacter)
}
