//
//  DetailViewController.swift
//  ch_03
//
//  Created by formegusto on 2021/11/02.
//

import UIKit

class DetailViewController: UIViewController {

    var someString = ""
    
    @IBOutlet weak var labelSomeString: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        labelSomeString.text = someString
    }

}
