import UIKit

class SecondView: UIViewController {
    weak var delegate: DeliveryDataProtocol?
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func popAction(_ sender: Any) {
        let text = textField.text
        delegate?.deliveryData(text ?? "")
        self.navigationController?.popViewController(animated: true)
    }
    
}
