/*
 Video View는 기본적으로 있지 않다.
 때문에, 공간만 만들어주면 된다. UIView
 */
/*
 라벨을 한쪽을 전체공간으로 써버리면,
 글씨가 늘어났을 때, 어떤 것을 우선적으로 늘릴지 정의해주어야 한다.
 그래서 Title 쪽을 먼저 타이트 하게 잡고 싶으면,
 Title 쪽의 Hugging Priority를 높여준다.
 */
/*
 기본적으로 Label은 중앙부터 써져있게 되어 있다.
 그래서 Constraint를 =(Equals)로 주는 것이 아닌,
 >=과 같이 작거나 같거나 하는 특성을 넣어준다.
 */
import UIKit
// AVKit
// Play 가능
import AVKit

class DetailViewController: UIViewController {

    var isPlayed = false
    var movieResult: Result?
//    {
//        didSet {
//            // 값을 넣었을 때
//            // 아직 생성되지 않아서 에러가 난다.
//            titleLabel.text = movieResult?.trackName
//            descLabel.text = movieResult?.longDescription
//        }
//    }
    
    @IBOutlet weak var playButton: UIImageView! {
        didSet {
            playButton.layer.zPosition = 1
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(changeMovieState))
            playButton.isUserInteractionEnabled = true
            playButton.addGestureRecognizer(tabGesture)
        }
    }
    @IBOutlet weak var pauseButton: UIImageView! {
        didSet {
            pauseButton.layer.zPosition = 1
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(changeMovieState))
            pauseButton.isUserInteractionEnabled = true
            pauseButton.addGestureRecognizer(tabGesture)
        }
    }
    @IBOutlet weak var closeButton: UIImageView! {
        didSet {
            closeButton.layer.zPosition = 1
            let tabGesture = UITapGestureRecognizer(target: self, action: #selector(closeMovie))
            closeButton.isUserInteractionEnabled = true
            closeButton.addGestureRecognizer(tabGesture)
        }
    }
    @IBOutlet weak var movieContainer: UIView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 24, weight: .medium)
        }
    }
    @IBOutlet weak var descLabel: UILabel! {
        didSet {
            descLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    
    var player: AVPlayer?
    override func viewDidLoad() {
        // 화면이 다 준비됐을 때, 호출되기 때문에 그 때 값을 넣어주면
        // 변경됨이 보이지 않는다.
        super.viewDidLoad()

        titleLabel.text = movieResult?.trackName
        descLabel.text = movieResult?.longDescription
        
//        if let hasUrl = movieResult?.previewUrl {
//            // viewDidLoad 시점에는 작업창에 대한 (Storyboard)
//            // 크기만 알고 있을 뿐, 실제 디바이스 크기는 알고 있지 않다.
//            makePlayerAndPlay(urlString: hasUrl)
//        }

        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // 다 그려지고 끝나기 전 시점
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        // 다 그려진 시점
        super.viewDidAppear(animated)
        // 실제로 디바이스의 크기를 가지고 오는 시점
        if let hasUrl = movieResult?.previewUrl {
            makePlayerAndPlay(urlString: hasUrl)
        }
    }
    func makePlayerAndPlay(urlString: String) {
        if let hasUrl = URL(string: urlString) {
            let player = AVPlayer(url: hasUrl)
            /*
             화면에 옮기는 기능
             AVPlayer 자체는 크기에 대한 개념을 가지고 있지 않기때문에
             넣어줘야 한다. 그게 PlayerLayout
             */
            let playerLayout = AVPlayerLayer(player: player)
            
            /*
             playerLayout은 Layer 개념이라 layer로 올려야한다.
             */
//            movieContainer.addSubview(<#T##view: UIView##UIView#>)
            movieContainer.layer.addSublayer(playerLayout)
            /*
             layer는 autolayout 개념이 없다.
             frame 절대값 기능만 있다.
             그래서 절대적인 값과 절대적인 좌표값이 필요하다.
             */
            playerLayout.frame = movieContainer.bounds
            player.play()
            self.player = player
            self.isPlayed = true
        }
    }
    
    @objc func closeMovie() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func changeMovieState() {
        if self.isPlayed {
            player?.pause()
            self.isPlayed = false
        } else {
            player?.play()
            self.isPlayed = true
        }
    }
}
