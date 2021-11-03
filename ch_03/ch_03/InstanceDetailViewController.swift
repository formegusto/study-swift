//
//  InstanceDetailViewController.swift
//  ch_03
//
//  Created by formegusto on 2021/11/03.
//

import UIKit

class InstanceDetailViewController: UIViewController {
    
    var mainVC: ViewController?
    @IBAction func sendDataMainVC(_ sender: Any) {
        mainVC?.dataLabel.text = "some string from instance screen."
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
