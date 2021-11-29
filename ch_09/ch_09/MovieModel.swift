import Foundation

// JSON 형식을
// 바로 인코딩 디코딩 할 수 있는 클래스 상속
struct MovieModel: Codable{
    let resultCount: Int
    let results: [Result]
}

// 데이터가 없는 경우를 고려해서,
// 전부 다 옵셔널로 설정해준다. (실제 그런 상황이 많다고 하시네요!)
struct Result: Codable {
    let trackName: String?
    let previewUrl: String?
    let image: String?
    let shortDescription: String?
    let longDescription: String?
    let currency: String?
    let trackPrice: Double?
    let releaseDate: String?
    let priviewUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case previewUrl
        case image = "artworkUrl100"
        case shortDescription
        case longDescription
        case currency
        case trackPrice
        case releaseDate
        case priviewUrl
    }
}

//struct Result: Codable {
//    let trackName: String
//    let previewUrl: String
//    let artworkUrl100: String
//
//    // JSON 으로 받아오고, 변수 이름은 다르게 쓰고 싶을 때 이렇게 쓴다.
//    enum CodingKeys: String, CodingKey {
//        case image = "artworkUrl100"
//        case trackName
//        case previewUrl
//    }
//}
