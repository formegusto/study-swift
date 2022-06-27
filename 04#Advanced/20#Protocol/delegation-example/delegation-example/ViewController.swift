//
//  ViewController.swift
//  delegation-example
//
//  Created by formegusto on 2022/06/27.
//

import UIKit

class ViewController: UIViewController, DeliveryDataProtocol {
    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataLabel.isHidden = true
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SecondView") as? SecondView else {
            return
        }
        secondVC.delegate = self
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    

    func deliveryData(_ data: String) {
        dataLabel.isHidden = false
        dataLabel.text = data
    }
}

protocol DeliveryDataProtocol: AnyObject {
    func deliveryData(_ data: String)
}
