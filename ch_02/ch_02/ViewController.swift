//
//  ViewController.swift
//  ch_02
//
//  Created by formegusto on 2021/10/17.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TestButton: UIButton!
    @IBAction func doSomething(_ sender: Any) {
        if (TestButton.backgroundColor == .red) {
            TestButton.backgroundColor = .orange
        }
        else if (TestButton.backgroundColor == .orange) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let detailVC = storyboard.instantiateViewController(identifier: "DetailVC") as DetailVC
            
            self.present(detailVC, animated: true, completion: nil)
        }
        else {
            TestButton.backgroundColor = .red
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TestButton.backgroundColor = UIColor.red
    }
    
    
}

