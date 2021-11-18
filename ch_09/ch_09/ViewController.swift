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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if let nowModel = movieModel?.results[indexPath.row] {
            cell.titleLabel.text = nowModel.trackName
            cell.descLabel.text = nowModel.shortDescription ?? nowModel.longDescription
//            cell.dateLabel.text = nowModel.releaseDate.
            cell.priceLabel.text = nowModel.currency + " " + nowModel.trackPrice.description
        }
        
        
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

