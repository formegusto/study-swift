

import UIKit

class ViewController: UIViewController {

    @IBAction func moveToDetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        self.present(detailVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

