/*
 이전과 같이 분산해서 함수를 만들면 눈에 들어오지 않는다.
 그래서 이를 모듈화 한다.
 */
import Foundation

enum RequestType {
    case justURL(urlString: String)
    // URL + Params
    case searchMovie(queries: [URLQueryItem])
}

class NetworkLayer {
    // loadImage , requestAPI
    
    typealias NetworkCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void
    func request(type: RequestType, completion: @escaping NetworkCompletion) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        // type에 따라 request 모양이 바뀌면 된다.
        do {
            let request = try buildRequest(type: type)
            
            session.dataTask(with: request) { data, response, error in
                print((response as! HTTPURLResponse).statusCode)
                
                
                completion(data,response,error)
            }.resume()
            session.finishTasksAndInvalidate()
        } catch {
            print(error)
        }
    }
    
    enum RequestError: Error {
            case badURL
    }
    
    private func buildRequest(type: RequestType) throws -> URLRequest {
        switch type {
        case .justURL(urlString: let urlString):
//            if let hasUrl = URL(string: urlString){
//                var request = URLRequest(url: hasUrl)
//                request.httpMethod = "GET"
//                return request
//            }
            guard let hasUrl = URL(string: urlString) else {
                throw RequestError.badURL
            }
            var request = URLRequest(url: hasUrl)
            request.httpMethod = "GET"
            return request
        case .searchMovie(queries: let queries):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = queries
            
            
//            if let hasUrl = components?.url {
//                var request = URLRequest(url: hasUrl)
//                request.httpMethod = "GET"
//                return request
//            }
            guard let hasUrl = components?.url  else {
                throw RequestError.badURL
            }
            
            var request = URLRequest(url: hasUrl)
            request.httpMethod = "GET"
            return request
        }
        // optional로 nil을 리턴하는 방법도 있지만
        // 예외를 던지는 방법도 소개
        // nil은 에러상황에 대해서 설명하지 않는다.
        
    }
}
