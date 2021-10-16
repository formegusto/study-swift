// Enumerations

// enum
// 타입분류

// 도서관
// 항목
//  - 소설, 문제집, 패션, 만화책

// 분류만 하고 싶은 경우
enum BookType {
    case fiction
    case comics
    case workbook
    // ...
}

// usage
var bookStyle: BookType?
var books = [BookType]()

func saveBook(book: BookType) {
//    switch book {
//    case .comics:
//        // 코믹스 카테고리 저장 로직,,
//    case .fiction:
//        // 소설 카테고리 저장 로직,,
//    case .workbook:
//        // 문제집 카테고리 저장 로직,,
//    }
    books.append(book)
}

func loadBook(book: BookType) -> [BookType] {
    var tempBooks = [BookType]()
    
    for item in books {
        if item == book {
            tempBooks.append(item)
        }
    }
    
    return tempBooks
}

saveBook(book: .comics)
saveBook(book: .fiction)
saveBook(book: .workbook)

books
loadBook(book: .comics)

// 분류 + 값
enum BookValueType {
    case fiction(title: String, price: Int, year: Int)
    case comics(title: String, price: Int, year: Int)
    case workbook(title: String, price: Int, year: Int)
}

var bookValues = [BookValueType]()
func saveBookValue(book: BookValueType) {
    bookValues.append(book)
}
saveBookValue(book: .comics(title: "재밌는 1", price: 2000, year: 2012))
saveBookValue(book: .fiction(title: "재밌는 2", price: 2000, year: 2012))
saveBookValue(book: .workbook(title: "재밌는 3", price: 2000, year: 2012))

// case let 이라는 개념을 알고 있으면 좋다.
for book in bookValues {
    switch book {
    case let .comics(title, price, year):
        print("comics", price)
    case let .fiction(title, price, year):
        print("fiction", title)
    case let .workbook(title, price, year):
        print("workbook", year)
    default: break
    }
}

// 특정 값만 가지고 와서 쓰고 싶은 경우
for book in bookValues {
    if case let BookValueType.fiction(title, price, year) = book {
        print("comics", title)
    }
}

// 이것들을 확장 시킬 수 있다.
extension BookValueType {
    var typeName: String {
        switch self {
        case .comics:
            return "코믹"
        case .fiction:
            return "소설"
        case .workbook:
            return "문제집"
        default:
            return ""
        }
    }
}

// 그러면 나중에 아래와 같이 사용 가능
for book in bookValues {
    switch book {
    case let .comics(title, price, year):
        print(book.typeName, "comics", price)
    case let .fiction(title, price, year):
        print(book.typeName,"fiction", title)
    case let .workbook(title, price, year):
        print(book.typeName,"workbook", year)
    default: break
    }
}
