import UIKit

class ClosureDetailViewController: UIViewController {

    // closure type
    var myClosure: ((String) -> Void)?
    @IBAction func closurePassData(_ sender: Any) {
        // 오는 곳에서 설정한 경우 작동한다.
        myClosure?("some string from closure screen.")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
