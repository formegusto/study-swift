//
//  ViewController.swift
//  05#access, observer property
//
//  Created by formegusto on 2022/07/20.
//

import UIKit

class ViewController: UIViewController {

    var _ap: String  = ""
    var apLength: Int {
        get {
            return self._ap.count
        }
    }
    private(set) var ap: String {
        get {
            return self._ap
        }
        set(newValue) {
            if newValue.contains(where: { Character in Character == "1"}) {
                self.apLabel.text = "1이 포함된 문자열은 저장할 수 없습니다."
                self._ap = ""
            } else {
                self.apLabel.text = "변수 _a 수정 중입니다."
                self._ap = newValue
            }
        }
    }
    @IBOutlet weak var apLengthLabel: UILabel!
    @IBOutlet weak var apLabel: UILabel!
    
    var op: String = "" {
        willSet(newValue) {
            self.willSetObserving.text = self.op
        }
        didSet(oldValue) {
            self.didSetObserving.text = self.op
        }
    }
    @IBOutlet weak var willSetObserving: UILabel!
    @IBOutlet weak var didSetObserving: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func accessPropertyValueChange(_ sender: UITextField) {
        self.ap = sender.text ?? ""
        self.apLengthLabel.text = self.apLength.description
    }
    @IBAction func observerPropertyValueChange(_ sender: UITextField) {
        self.op = sender.text ?? ""
    }
    
    @IBAction func getAp(_ sender: Any) {
        self.apLabel.text = self.ap
    }
}

