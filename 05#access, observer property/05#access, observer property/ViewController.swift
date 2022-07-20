//
//  ViewController.swift
//  05#access, observer property
//
//  Created by formegusto on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {

    var ap: String = "" {
//        get {
//            return self.ap
//        }
//        set(newValue) {
//            self.ap = newValue
//        }
        willSet {
            print(self.ap)
        }
        didSet {
            print(self.ap)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func accessPropertyValueChange(_ sender: UITextField) {
        print(sender.text)
        self.ap = sender.text ?? ""
    }
    
}

