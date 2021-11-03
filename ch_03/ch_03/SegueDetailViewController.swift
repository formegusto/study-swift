//
//  SegueDetailViewController.swift
//  ch_03
//
//  Created by formegusto on 2021/11/03.
//

import UIKit

class SegueDetailViewController: UIViewController {

    
    @IBOutlet weak var segueLabel: UILabel!
    var segueString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        segueLabel.text = segueString
    }

}
