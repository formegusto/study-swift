import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. title 설정
        setNaviTitle()
        
        // 2. navigate
        // storyboard 상에서도 controll간의 이동을 버튼 액션으로
        // ctrl 버튼을 누른상태로 끌면 설정이 가능하다.
        // navigation controller 구조에서는 기본적으로 다음 네비게이션에
        // backbutton 이라는 것이 생긴다.
        
        // 3. mgmt back button
        makeBackBtn()
        
        // 4. viewWillAppear
        
        
        // 5. rightBarButton
        makeRightAlarmButton()
    }
    
    func makeRightAlarmButton() {
        let image = UIImage(systemName: "alarm.fill")?.withRenderingMode(.alwaysTemplate)
        let rightItem = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(rightItemClick))
        
        let image2 = UIImage(systemName: "book.fill")?.withRenderingMode(.alwaysTemplate)
        let rightItem2 = UIBarButtonItem(image: image2, style: .done, target: self, action: #selector(rightItemClick))
        
        // 버튼간의 간격에 대하여 ( inset 해도 제 위치에서 잘 작동한다. )
        rightItem2.imageInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        
        // customView 이용방법
        // 이전에도 봤듯이, view만 잘만들면 title에 뭐든지 붙일 수 있음
        let config = UIImage.SymbolConfiguration(pointSize: 24)
        
        let btn1 = UIButton()
        btn1.setImage(UIImage(systemName: "paperplane.fill", withConfiguration: config), for: .normal)
        btn1.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let btn2 = UIButton()
        btn2.setImage(UIImage(systemName: "tray.fill", withConfiguration: config), for: .normal)
        btn2.addTarget(self, action: #selector(rightItemClick), for: .touchUpInside)
        let stackView = UIStackView(arrangedSubviews: [btn1, btn2])
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        let customItem = UIBarButtonItem(customView: stackView)
        
        
        // items로 2개 넣을 수 있음
        // self.navigationItem.rightBarButtonItems = [rightItem, rightItem2]
        self.navigationItem.rightBarButtonItem = customItem
        self.navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    @objc func rightItemClick() {
        print("i'm right :)")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 앞에서 뒤로 돌아올 때 색 처리하기 위해
        // 4. navigation background
        naviBackgroundDesign()
    }
    
    func naviBackgroundDesign() {
        
        // iOS 15
        // 이렇게 해주기도 함.
        // let appearance = UINavigationBarAppearance()
        // appearance.configureWithOpaqueBackground()
        // appearance.backgroundColor = .red
        
        // self.navigationController?.navigationBar.standardAppearance = appearance
        // self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
        // 이게 iOS14 시절에는 은은하게 들어가는 것이 있었다는데 없어진듯,,
        // 아무튼 이 설정이 true로 잡혀있어서 그런거임.
        // self.navigationController?.navigationBar.barTintColor = .red.withAlphaComponent(0.1)
        // self.navigationController?.navigationBar.backgroundColor = .red.withAlphaComponent(0.5)
         // self.navigationController?.navigationBar.isTranslucent = true
        // 하지만 이 반투명 영역을 false로 없애버리면 navaigationBar 구조가 팍외~ 되버려서 아예 색 적용이 안됨
        // 그래서 아래와 같이 이미지를 넣어서 적용시키기도 했음.
        // 결론 : 근데 15이후에는 그냥되니까 그냥 하면됨
        //   self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        
        self.navigationController?.navigationBar.backgroundColor = .systemBlue
        
        /*
        // status bar 변경
        // 예전에는 직접 접근이 됐는데, 업데이트 되면서 막혔다. 그래서 위에 view를 올리는 느낌으로 가야한다.
        // 모든화면에 동일하게 적용되야함으로, 싱글톤으로 구성해야 하는데,
        // 예전에는 appDelegate에서 이 작업을 했었다.
        // 이제는 이러한 모든 바탕에 대한 작업을 SceneDelegate에서 한다.
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        // window 인거 찾아서 가지고 온다.
        let window = UIApplication.shared.windows.filter{ $0.isKeyWindow }.first
        if let hasStatusBar = sceneDelegate?.statusBarView {
            window?.addSubview(hasStatusBar)
        }
         */
        self.statusBar?.backgroundColor = .systemBlue
    }
    
    func makeBackBtn() {
        // self.navigationItem.backButtonTitle = "뒤로"
        // 여기도 custom view 설정 가능 (image도 된다)
        // 맨 왼쪽의 애로우를 다루는 설정은 아님, 타이틀을 바꾸는 설정
        // self.navigationItem.backBarButtonItem = UIBarButtonItem(systemItem: .bookmarks)
        
        // 두 쪽에 다 넣어줘야 바꿔진다.
        // let backImage = UIImage(systemName: "delete.backward")
        // 아래 이미지는 tintColor와 같은 것들이 아예 적용안되도록 막는다.
        // let ogMyImage = UIImage(systemName: "delete.backward")?.withRenderingMode(.alwaysOriginal)
        // alwaysTemplate 는 설정 값대로
        
        // 이미지를 선명하게 내기 위해
        // 적용값의 3배를 하는데, 이 때 @3x라는 키워드를 쓴다.
        // 하지만 파일적용할때는 이를 안 적어줘도 된다.
        let customImage = UIImage(named: "MdOutlineAccessibilityNew")
        
        // 못 받는 상황에서 아래와 같이 적용
        //
        // let newWidth = 40
        // let newHeight = 40
        // let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        // 빈 도화지를 생성 -> 받기 -> 끝내기
        // UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        // customImage?.draw(in: newImageRect )
        // let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // UIGraphicsEndImageContext()
        if let hasImage = customImage {
            let newImage = resizeImage(image: hasImage)
            
            self.navigationController?.navigationBar.backIndicatorImage = newImage
            self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = newImage
            self.navigationController?.navigationBar.tintColor = .white
            
            // customImage
            // self.navigationController?.navigationBar.tintColor = .systemRed
            self.navigationItem.backButtonTitle = ""
        }
        
    }
    
    func resizeImage(image: UIImage) -> UIImage? {
        let newWidth = 40
        let newHeight = 40
        let newImageRect = CGRect(x: 0, y: 0, width: newWidth, height: newHeight)
        
        // 빈 도화지를 생성 -> 받기 -> 끝내기
         UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
         image.draw(in: newImageRect )
         let newImage = UIGraphicsGetImageFromCurrentImageContext()
         UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func setNaviTitle() {
        // 1. title에 text 넣기
        // self.title = "메인 화면"
        // === eq
        // self.navigationItem.title = "메인 화면"
        
        // 2. title에 image 넣기
        // let logo = UIImageView(image: UIImage(named: "keti_logo 1"))
        
        // 통상적으로 naviation bar의 높이는 40 - 44
        // width 3 - 413
        // logo.contentMode = .scaleAspectFit // 비율을 망가뜨리지 않는다.
        // logo.widthAnchor.constraint(equalToConstant: 120).isActive = true
        // logo.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // self.navigationItem.titleView = logo
        
        // 3. title에 button 넣기
        let btn = UIButton()
        // btn.backgroundColor = .systemBlue
        // btn.backgroundColor = .white.withAlphaComponent(0.1)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("custom button", for: .normal)

        btn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true

        btn.addTarget(self, action: #selector(testAction), for: .touchUpInside)
        self.navigationItem.titleView = btn

        // 결론 아무거나 넣을 수 있는데 잘 만들면 됨.
    }

    @objc func testAction() {
        print("test success :)")
    }

}

