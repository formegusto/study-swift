import UIKit

/*
 Hugging Priority 로 layout 잡는 거 해보기!
 
 // API Info
 http://resources.organicfruitapps.com/documentation/itunes-store-web-service-search-api/
 
 
 */
class ViewController: UIViewController {

    var movieModel: MovieModel?
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var movieTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        
        // 이벤트용으로 쓸거기 때문에!
        searchBar.delegate = self
        
        requestMovieAPI()
    }

    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void){
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        if let hasUrl = URL(string: urlString) {
            var request = URLRequest(url: hasUrl)
            request.httpMethod = "GET"
            
            session.dataTask(with: request) { data, response, error in
                print((response as! HTTPURLResponse).statusCode)
                
                // 제공해주는 것이 있다!
                // Swift 짱짱!
                
                if let hasData = data {
                    // 하지만 클로저는 다른 쓰레드가 생성되는 개념이다.
                    // 현재 함수의 반환 주체가 아님
                    // 그래서 이를 반환하기 보다는 다른 쓰레드에서 만들어진 함수를 받아와서
                    // 거기서 사용하는 것이 좋다.
                    // return UIImage(data: data)
                    completion(UIImage(data: hasData))
                    // data가 image data가 아닐 수도 있어서
                    return
                }
                /*
                 Escaping
                 위의 클로저는 끝나는 대로 바로 사라지는 특징이 있다.
                 매개변수도 마찬가지이다.
                 때문에, completion 실행동안 data 변수를 살려놓기 위해, 위쪽 클로저
                 함수에 @escaping keyword를 붙여준다.
                 */
            }.resume()
            session.finishTasksAndInvalidate()
        }
        
        // 실패했을 경우,
        completion(nil)
    }
    
    // network 호출
    func requestMovieAPI() {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        var components = URLComponents(string: "https://itunes.apple.com/search")
        
        let term = URLQueryItem(name: "term", value: "marvel")
        let media = URLQueryItem(name: "media", value: "movie")
        
        components?.queryItems = [term, media]
        guard let url = components?.url else {
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // 이런식으로 다른곳에서 빼서 할 수도 있다. 하지만 지금은 예외라 그냥 진행
        let task = session.dataTask(with: request) { data, response, error in
            print((response as! HTTPURLResponse).statusCode)
            
            if let hasData = data {
                do {
                    self.movieModel = try JSONDecoder().decode(MovieModel.self, from: hasData)
                    
                    print(self.movieModel ?? "no data")
                    
                    // 클로저이기 때문에,,
                    DispatchQueue.main.async {
                        self.movieTableView.reloadData()
                    }
                    
                } catch {
                    print(error)
                }
            }
//            JSONDecoder.
            
        }
        
        // 이거는 관례다. 해줘야함
        task.resume()
        session.finishTasksAndInvalidate()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieModel?.resultCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 예전버전에서는 자동으로 안 잡히는 버전들이 있어서
        // 잡아놔주는게 좋다.
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if let nowModel = movieModel?.results[indexPath.row] {
            cell.titleLabel.text = nowModel.trackName
            cell.descLabel.text = nowModel.shortDescription ?? nowModel.longDescription
//            cell.dateLabel.text = nowModel.releaseDate.
            cell.priceLabel.text = nowModel.currency + " " + nowModel.trackPrice.description
            self.loadImage(urlString: nowModel.image) { image in
                DispatchQueue.main.async {
                    cell.movieImageView.image = image
                }
            }
            
            let dateString = nowModel.releaseDate
            let formatter = ISO8601DateFormatter()
            if let isoDate = formatter.date(from: dateString) {
                let myFormatter = DateFormatter()
                myFormatter.dateFormat = "yyyy년 MM월 dd일"
                cell.dateLabel.text = myFormatter.string(from: isoDate)
            }
        }
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

