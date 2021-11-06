/*
 1. Layout
    - 오른쪽 하단 왼쪽 두번째 메뉴
        Horizontally in Container
        Vertically in Container
        : 중간 정렬 할 때 사용
    - Label 관련
        Grouping 하고 싶은 Component들 잡아서
        오른쪽 하단 오른쪽 첫번째 메뉴
        View : 일일이 간격 지정해줘야 한다고함
        Scroll View : 이름 그대로
        Stack View : 이거 쓰삼
  2. Stack View
    - 방향 설정이 가능하다. Flex
    - 아이템들간의 사이 간격을 설정할 수 있다. : Spacing
  3. Label
    - 반드시 간격 Constrain 설정을 해주어야 한다.
    - 안하면 옆으로 늘어났을 때, 밖으로 나가버리는 현상이 발생한다.
  4. Constrain
    - 옆에 이웃들이 제약사항이 걸려있어야 조화롭게 걸림
    - 명심명심!
    - 제약사항으로 해결해야 모든 크기의 디바이스에 대응할 수 있음
 */

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var topTitle: UILabel!
    @IBOutlet weak var bottomDesc: UILabel!
    override func awakeFromNib() {
        // table cell의 시작점
        super.awakeFromNib()
        // Int랑 Float 연산이 안돼서 CGFloat 사용 ( Type Casting )
        let profileImageHeight: CGFloat = 60
        profileImageView.layer.cornerRadius = profileImageHeight / 2
        
        topTitle.textColor = .blue
        topTitle.font = UIFont.systemFont(ofSize: 20)
        
        bottomDesc.textColor = .darkGray
        bottomDesc.font = UIFont.systemFont(ofSize: 16)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
