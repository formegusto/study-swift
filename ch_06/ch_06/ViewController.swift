//
//  ViewController.swift
//  ch_06
//
//  Created by formegusto on 2021/11/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = DraggableView()
        // 초기 위치 및 얼마나 떨어뜨릴 건지, 크기 설정
        myView.center = self.view.center
        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        myView.backgroundColor = .red
        
        self.view.addSubview(myView)
        
    }


}

