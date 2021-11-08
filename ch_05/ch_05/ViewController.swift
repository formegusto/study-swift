/*
 Settings Clone
 테이블 뷰에서 하나의 아이템을 셀이라고 표현한다.
 
 1. Layout
    오른쪽 하단 3번째 메뉴
    - constrain to margins
        일정 여백 (8, 10) 필요할 때 사용, 보통 잘 안 쓴다.
    - 화면에 꽉 차게 자리를 잡기위해서는
        모든 constrain 값을 0으로 주면된다.
    - 위쪽 아래쪽의 여백은 기본적으로 사용하지 않는 SafeArea 라는 공간이다.
 2. Storyboard? XIB? NIB
    - Storyboard
        기본적으로 작업의 단위가 Controller이다.
    - XIB, NIB
        단위가 View 이다.
 
 */

import UIKit

class ViewController: UIViewController {
    // Section의 개념을 넣어서
    // [Section][SettingModel Array]
    var settingModel = [[SettingModel]]()
    
    // Image Name 은 SF Symbols3 App 참고해서 이름을 쓴다.
    func makeData() {
        settingModel.append([SettingModel(leftImageName: "person.circle", menuTitle: "Sign in to your iPhone", subTitle: "Set up iCloud, the App Store, and more.", rightImageName: "chevron.right")]
        )
        
        settingModel.append([SettingModel(leftImageName: "gear", menuTitle: "General", subTitle: nil, rightImageName: "chevron.right"),SettingModel(leftImageName: "figure.stand", menuTitle: "Accessibility", subTitle: nil, rightImageName: "chevron.right"),
         SettingModel(leftImageName: "hand.raised.fill", menuTitle: "Privacy", subTitle: nil, rightImageName: "chevron.right")])
    }
    
    @IBOutlet weak var settingTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Cell Class 로 가져오는 방법
        // settingTableView.register(<#T##cellClass: AnyClass?##AnyClass?#>, forCellReuseIdentifier: <#T##String#>)
        
        // tableView 해당 프로토콜을 준수해서 연동되게 하겠다라는 부분을
        // self로 잡아줘야 한다.
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.backgroundColor = UIColor(white: 244/255, alpha: 1)
        
        // NIB File 가지고 오기
        let nib = UINib(nibName: "ProfileCell", bundle: nil)
            // 파일명 명시
        settingTableView.register(nib, forCellReuseIdentifier: "ProfileCell")
            // forCellReuseIdentifier 은 cell에 등록한,
            // Restoration ID 를 적어주면 된다. 보통 파일명이랑 똑같이 설정한다.
        
        settingTableView.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
        
        /*
         TableView 에서는 프로토콜 규격을 준수해야 한다.
         UITableViewDelegate, UITableViewDataSource
         확장 설정 시 에러가 나는데 에러창에서 Fix 버튼 눌러주면 자연스럽게
         구현해야하는 메서드들이 생성된다.
         */
        
        /*
         Navigation Controller를 위한 Title 설정
         */
        self.title = "Settings"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.view.backgroundColor = UIColor(white: 244/255, alpha: 1)
        
        makeData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 셀이 몇 개 나타날지 정의하는 부분
        // return someData.count
        // return 5
        // secion을 참고하여 section 마다 몇개의 행이 나타나는지 정의해준다.
        return settingModel[section].count
    }
    
    // 섹션의 대한 개수 정의도 필요하다.
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 어떤 셀을 보여줄거냐 하는 부분
        
        // 셀을 재사용하겠다는 의미의 메서드
        // 그래서 cell을 반환한다.
        // withIdentifier 에는 재사용 셀의 Restoration ID
        // for 에는 순서적인 부분
        // let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
        
        if indexPath.section == 0 {
            // let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath)
            // 강제 캐스팅 해주는 부분이 필요하다.
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
            
            cell.topTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
            cell.profileImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
            cell.bottomDesc.text = settingModel[indexPath.section][indexPath.row].subTitle
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.leftImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].leftImageName)
        cell.leftImageView.tintColor = .orange
        cell.middleTitle.text = settingModel[indexPath.section][indexPath.row].menuTitle
        cell.rightImageView.image = UIImage(systemName: settingModel[indexPath.section][indexPath.row].rightImageName ?? "")
        cell.rightImageView?.tintColor = .lightGray
        
        return cell
    }
    
    // Cell 높이 지정
    // 1. 함수 지정
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    // 2. table cell class에
    // cell의 요소 중 하나한테 constrain 위 아래로 걸어놓기
    // 혹은 오른쪽 상단의 삼각형 모양 메뉴에서 Vertical 간격 설정
    // 우선순위는 무조건 1번이 먼저
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            // 자동으로 잡히게 하는 방법
            return UITableView.automaticDimension
        }
//        return 60
        return UITableView.automaticDimension
    }
    // Section
    
    // Setting App 을 보면, 테이블 그룹이 나누어져 있는 것을 볼 수 있는데
    // 이것을 Section 이라 한다.
}


/*
 Navigation Controller
  - Controller 선택 후 -> Editor -> Embed in -> Navigation Controller
  - Navigation 은 ViewController를 감싸고 있는 형태라고 생각하면 된다.
  - 때문에 Navigation Controller는 무언가를 만들거나 하는 것이 아니다.
    단지 타이틀과 뷰만 가지고 있는 형태이다.
 */
