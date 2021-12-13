//
//  ViewController.swift
//  ch_11
//
//  Created by formegusto on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customButton: RotateButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customButton.selectTypeCallback = { upDownType in
            print(upDownType)
        }
        // Code 로 올리기
        /*
        // let myButton = RotateButton();
        // self.view.addSubview(myButton)
        
        // frame 으로 올리기
        // myButton.translatesAutoresizingMaskIntoConstraints = true
        // myButton.frame = CGRect(x: 100, y:200, width: 200, height: 50)
        
        // autoLayout
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true // 중앙
        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        // myButton.widthAnchor.constraint(equalToConstant: 150).isActive = true // 100 크기
        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        myButton.backgroundColor = UIColor.orange
        myButton.setTitle("my custom button", for: .normal)
        myButton.setImage(UIImage(systemName: "arrow.down"), for: .normal)
         */
    }


}

