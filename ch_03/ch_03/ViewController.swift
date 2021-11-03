// passing data ( 데이터를 넘겨주는 방법 )
// 6 가지

// 1. instance property
// 2. segue
    // 여러개의 ViewController가 하나의 스토리 보드에 있을 때 사용한다.
// 3. instance
    // 핵심은 나를 넘겨줘서 (복사가 아님, 포인터 주소개념) 내가 가지고 있는 것들을 제어할 수 있도록 한다는 의미
// 4. delegate (delegation) pattern
    // 대리, 위임, 대신
// 5. Closure
    // Closure 도 호출부와 실행부가 나눠져 있을 수 있다.
    // delegate pattern과 유사
// 6. Notification
    
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var keyboardNotice: UILabel!
    @IBAction func moveToDetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        detailVC.someString = "hello, formegusto."
        // 여기서는 사용할 수 없다. (메모리에 올라가지 않음)
        // detailVC.labelSomeString.text = "hello, formegusto's label."
        self.present(detailVC, animated: true, completion: nil)
        
        // 모든 것들이 준비가 되어야 올라간다.
        detailVC.labelSomeString.text = "hello, formegusto's label."
    }
    
    /*
     2. segue
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            // segue는 Destination 이라는 것이 있다.
            if let detailVC = segue.destination as? SegueDetailViewController {
                detailVC.segueString = "hello! Segue!"
            }
        }
    }
    
    /*
     3. Instance
     */
    @IBAction func moveToInstance(_ sender: Any) {
        let detailVC = InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        detailVC.mainVC = self
        self.present(detailVC, animated: true, completion: nil)
        
    }
    
    /*
     4. Delegate
     // 여기에 만들었다고 위에서 self를 적용하는 부분들에 대해서는 걱정을 하지 않아도 된다. 상속의 관계에서 봤을 때, 이런 경우 모든 클래스들은 자기가 가지고 있는 것들만 바라볼 수 있다.
     */
    @IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        detailVC.delegate = self // 본인이 규격을 맞추고 있어야 한다.
        self.present(detailVC, animated: true, completion: nil)
        
    }
    
    /*
     5. Closure
     */
    @IBAction func moveToClosure(_ sender: Any) {
        let detailVC = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        detailVC.myClosure = { str in
            self.dataLabel.text = str
        }
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    /*
     6. Notification
      생성한 Notification 으로 무언가 발생하면 실행되도록
      구조를 형성한다.
     
      주의점 : 호출과 등록의 개념을 알아야 한다.
        등록을 하나하고 호출을 세번 하면 3번, 등록된 것이 호출되지만,
        등록을 두개하고 호출을 세번 하면 총합 6번, 등록된 것들이 호출된다.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("send some string")
        NotificationCenter.default.addObserver(self, selector: #selector(showSomeString), name: notificationName, object: nil)
        
        /*
         *. Notification 활용
         - 키보드가 나타나는 순간에 어떤 작업을 하고 싶을 때,
         - UIResponder : IOS 관련 이벤트들이 나타날 때, 실행되나 보다.
         */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        /*
         remove
         */
//        NotificationCenter.default.removeObserver(self, name: notificationName, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.keyboardNotice?.text = "키보드님 들어가심,,"
    }
    @objc func keyboardWillShow() {
        self.keyboardNotice?.text = "키보드님 나타나신다"
    }
    
    @objc func showSomeString(notification: Notification) {
        // key - value 형태로 값이 있는 변수
        if let str = notification.userInfo?["str"] as? String {
            self.dataLabel.text = str
        }
    }
    @IBAction func moveToNotice(_ sender: Any) {
        let detailVC = NotiDetailViewController(nibName: "NotiDetailViewController", bundle: nil)
        self.present(detailVC, animated: true, completion: nil)
    }
    
    
}

/*
 4. Delegate 규격을 맞추기 위함
 */
extension ViewController: DelegateDetailViewControllerDelegate {
    func passString(string: String) {
        self.dataLabel.text = string
    }
}
