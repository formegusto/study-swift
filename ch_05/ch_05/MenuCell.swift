/*
 Constrain 설정 주의 사항
  - 삼각형 모양 아이콘 클릭하면
    우선순위 Priority를 볼 수 있는데,
    제약사항 우선순위이다. 1000이 가장 큰 값임
  - Content Hugging Priority
    가로, 세로 우선순위 크기를 결정하는 아주 중요한 것
  - 세세하게 다루고 싶으면 세세하게 다루면 된다.
 */

import UIKit

class MenuCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var middleTitle: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
