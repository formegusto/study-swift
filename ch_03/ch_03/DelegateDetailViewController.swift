//
//  DelegateDetailViewController.swift
//  ch_03
//
//  Created by formegusto on 2021/11/03.
//

import UIKit

// protocol 규격을 준수하도록 클래스를 구성한다.
protocol DelegateDetailViewControllerDelegate: AnyObject {
    func passString(string: String)
}

class DelegateDetailViewController: UIViewController {

    weak var delegate: DelegateDetailViewControllerDelegate?
    
    @IBAction func passDataToMainVC(_ sender: Any) {
        delegate?.passString(string: "Some String From Passing Delegate Screen")
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
