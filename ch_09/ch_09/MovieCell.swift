import UIKit


class MovieCell : UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = .systemFont(ofSize: 13, weight: .light)
        }
    }
    @IBOutlet weak var descLabel: UILabel! {
        didSet {
            descLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    @IBOutlet weak var priceLabel: UILabel! {
        didSet {
            priceLabel.font = .systemFont(ofSize: 14, weight: .bold)
        }
    }
    
    @IBOutlet weak var movieImageView: UIImageView!
    
}
