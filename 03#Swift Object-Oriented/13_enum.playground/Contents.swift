// Enumerations

// enum
// 타입분류

// 도서관
// 항목
//  - 소설, 문제집, 패션, 만화책
enum BookType {
    case fiction
    case comics
    case workbook
}
var bookStyle: BookType = BookType.fiction
//var books = [BookType]([BookType.fiction, BookType.comics])

//print(bookStyle) // comics
//for book in books {
//    print(book)
//}
/*
 fiction
 comics
 */


var books = [BookType]()
let saveBook: (BookType) -> Void = { books.append($0) }
let readBooks: () -> Void = {
    for book in books {
        print(book)
    }
}
saveBook(BookType.workbook)
saveBook(.comics)
books.append(.fiction)

readBooks()
/*
 workbook
 comics
 fiction
 */


//// 분류만 하고 싶은 경우
//enum BookType {
//    case fiction
//    case comics
//    case workbook
//    // ...
//}
//

enum BookValueType {
    case fiction(title: String, price: Int, year: Int)
    case comics(title: String, price: Int, year: Int)
    case workbook(title: String, price: Int, year: Int)
}
var bookValue: BookValueType = .comics(title: "안녕", price: 2000, year: 2010)
if case let .comics(title, price, year) = bookValue {
    print(title)
}

var bookValues = [BookValueType]()
func saveBookValue(_ book: BookValueType) {
    bookValues.append(book)
}
saveBookValue(.comics(title: "재밌는 1", price:2000, year: 2012))
saveBookValue(.fiction(title: "재밌는 2", price: 3000, year: 2020))
saveBookValue(.workbook(title: "재밌는 3", price: 4000, year: 2022))

for bookValue in bookValues {
    switch bookValue {
        case let .comics(title, price, year):
            print("comics", title, price)
        case let .fiction(title, price, year):
            print("comics", title, price)
        case let .workbook(title, price, year):
            print("comics", title, price)
    }
}

extension BookValueType {
    var typeName: String {
        switch self {
            case .comics:
                return "comic"
            case .fiction:
                return "fiction"
            case .workbook:
                return "workbook"
        }
    }
}

if case let .comics(title, price, year) = bookValues[0] {
    print(bookValues[0].typeName, title, price, year) // comic 재밌는 1 2000 2012
}
for bookValue in bookValues{
    switch bookValue {
        case let .comics(title, price, year):
            print(bookValue.typeName, title, price, year)
        case let .fiction(title, price, year):
            print(bookValue.typeName, title, price, year)
        case let .workbook(title, price, year):
            print(bookValue.typeName, title, price, year)
    }
}
