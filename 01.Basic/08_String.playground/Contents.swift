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

print(all) // hello, i am formegusto

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
print(isOn.description) // "false"
print(String(isOn)) // "false"

// Template
let myNumber = 123
print(myNumber.description)
let introMyNumber = "my number is \(myNumber)"
print(introMyNumber.dropLast())
print(introMyNumber.dropFirst())
print(introMyNumber)

// Split
for splitCharacter in introMyNumber.split(separator: " ") {
    print(splitCharacter)
}
