import UIKit

// unicode 범위 관련
// 숫자만 입력받을 수 있어야 한다.

let inputValues = ["5", "a"]
// Number Unicode 16 30 ~ 39
"\u{30}"
"\u{39}"

for inputValue in inputValues {
    if inputValue >= "\u{30}" && inputValue <= "\u{39}" {
        print("is Number")
    } else {
        print("is not Number")
    }
}

// 영어만 입력해야 한다.
// English Unicode
// 16 41 ~ 5a
// 16 61 ~ 7a
"\u{61}"
"\u{7a}"
"\u{41}"
"\u{5a}"
let inputValues2 = ["5", "a", "7", "A"]
for inputValue in inputValues2 {
    if (inputValue >= "\u{61}" && inputValue <= "\u{7a}") ||
        (inputValue >= "\u{41}" && inputValue <= "\u{5a}"){
        print("is English!")
    } else {
        print("is not English")
    }
}
