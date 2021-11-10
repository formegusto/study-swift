/*
 General ViewController는
 Navigation 구조를 가지고 있지만,
 MyIDViewController는
 Navigation 구조가 아니다. 이를 구현해보도록 하자.
 
 XIB로 만들게되면, ViewController가 아닌,
 View라는 개념이 형성되고 이를 관리하는
 File's Owner라는 것이있다.
 
 때문에, File's Owner에 MyIDViewController가
 연결되어 있는 것을 볼 수 있다.
 
 Label
  - Lines 0 설정 시, 무한의 줄~~~
 
 Image View
  - 이미지를 넣기 전까지는 크기가 잡히지 않음
  - 꿀팁 : Stack View로 잡고,
        전체 Aspect Ratio 주면,
        하나의 크기만 바꿔도 전체로 바뀜
 
 Stack View
  - Distribution에 Fill equally는
    가로 크기는 모두 같게 해주지만 (스택 뷰 크기에 맞춰서 ), 세로크기에는 관여하지 않는다.
    때문에, imgae view 자체의 constant를 만져주면
    해결된다!
 */
import UIKit

class MyIDViewController: UIViewController {

    @IBOutlet weak var cancleButton: UIButton!
    @IBAction func onPressCancleButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var nextButton: UIButton!{
        didSet{
            nextButton.isEnabled = false
        }
    }
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // target : 어디서 찾을거냐?
        emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        // 초반 세팅, 하지만 didSet으로 하는게 프로!
        // self.textFieldDidChange(sender: emailTextField)
    }

    @objc
    func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
            
        }
    }
}
