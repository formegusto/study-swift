# 2. App Build Intro

# 1. Project 생성

- File → New → Project
- Platform 선택 → App
- Product Name : custom
- Interface : Storyboard
- Language : Swift

# 2. Project General

- Bundle Identifier : 프로젝트의 고유 아이디, 보통 회사 주소를 거꾸로 돌려 쓰기도 한다.
- Deployment Info : IOS 버전 지원하는지 까지
  - 일반적으로 12.1 : 버전 2정도 내려서 쓴다. 그러면 사용률이 올라감. 많이 내리면 3정도
- 파일 구조
  - AppDelegate.swift
    - App을 처음 시작하는 시작점이다. 일반적인 프로그래밍의 Main 함수라고 생각하면 된다.
  - SceneDelegate.swift
    - 앱의 라이프사이클 관리
    - func sceneWillEnterForeground, func sceneDidEnterBackground 등이 있다.
  - ViewController.swift
    - 화면이 시작하는 점이 이곳이다. UIViewController를 상속받은 곳이 화면이다.
    - 화면이랑 코드랑 연결이 되어지는 부분이 정의 되어야 한다. 아래서 설명
  - Main.storyboard
    - 열면 폰 화면이 보인다.
    - 우리는 처음 시작하는 화면을 코드로도 정할 수 있고, 보통 잘 안함. 기본세팅으로 되어 있어서, 코드로 정하는 경우에는 AppDelegate에 직접 정의했는데, 지금은 프로젝트 속성에 Deployment Info → Main Interface 에서 정의한다.
    - 여기서 ViewController는 여러개 만들 수 있다. storyboard 창에서 오른쪽 상단의 + 버튼을 누르면 된다.
    - 어떤 것을 먼저 시작할지도 역시 코드로 안하고 화살표로 표시해서 설정한다. 그리고 View Controller에 is initial view controller 라는 체크란이 있는데 보통 이걸로도 잘 안한다. 화살표를 그냥 옮겨주면 된다.
    - 해당 파일의 와이어프레임 4번째 메뉴를 보게 되면 Custom Class 라는 파트가 있다. 여기서 해당 화면이 어떤 클래스와 연결되어야 하는지를 정의한다.
    - 만약 버튼을 생성하고, 코드랑 해당 컴포넌트를 연결시켜주면, 코드가 생성된다.
      ```swift
      class ViewController: UIViewController {

          @IBOutlet weak var TestButton: UIButton!
          override func viewDidLoad() {
              super.viewDidLoad()
              // Do any additional setup after loading the view.
          }

      }
      ```
      - IBOutlet 이란, 화면이랑 연결되어 있다는 것을 뜻한다.
      ```swift
      class ViewController: UIViewController {

          @IBOutlet weak var TestButton: UIButton!

          override func viewDidLoad() {
              super.viewDidLoad()
              // Do any additional setup after loading the view.

              TestButton.backgroundColor = UIColor.red
          }

      }
      ```
      - 실행은 command + R 누르면 된다. 위의 기기명을 누르면 기기를 바꿔서 실행시킬 수 있다.
    - action
      - 위의 처럼 컴포넌트를 소스코드로 옮겨주고, action란을 선택해주면 함수가 만들어진다.
      ```swift
      @IBAction func doSomething(_ sender: Any) {
          TestButton.backgroundColor = .orange
      }
      ```

# 3. class

- UIViewController 우리는 UIKit로 부터 받아와 UI를 만드는데, 이 중 화면은 UIViewController를 상속받는 클래스를 기반으로 한다.
- New File을 누르면, Swift File 혹은 Cocoa Touch Class를 만들 수 있는데, 이 중 Cocoa Touch Class를 어떤 클래스르 상속받을지 미리 정의하고 파일을 생성할 수 있다.

## 1. Navigate

- Cocoa Touch Class 로 만들고 화면의 present() 라는 상속 메서드를 사용해서 이동한다.
- 이 때, 이동할 화면에 연결된 클래스를 인스턴스화 해줘야 하는데, 이 화면이라는 거는 스토리보드를 기반으로 만들어진거기 때문에 스토리보드를 기반으로 가지고 와야 한다.

```swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
```

- 다음과 같이 현재화면의 스토리 보드를 가지고 온다. 그리고 이동할 화면을 지정해줘야 하는데, 이 때 해당 화면의 고유 아이디가 필요하다. 그래서 다시 Storyboard로 이동해서, 해당 화면의 Identity → Storyboard ID를 지정해준다. (보통 클래스 이름과 똑같이 지정한다.)
- 전체코드

```swift
let storyboard = UIStoryboard(name: "Main", bundle: nil)
let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as DetailVC

self.present(detailVC, animated: true, completion: nil)
```

- 당연하지만 작은 프로젝트는 굳이 파일별로 클래스를 두지 않아도 된다. 하나에 다 넣어놔도 된다.

## 2. Main LifeCycle Function

```swift
class DetailVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
}
```
