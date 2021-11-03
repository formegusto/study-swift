//
//  DetailViewController.swift
//  ch_03
//
//  Created by formegusto on 2021/11/02.
//

import UIKit

class DetailViewController: UIViewController {

    var someString = ""
    
    // 특별한 프로퍼티로 분류가 된다. (화면이랑 연결이 되어 있음)
    /*
     클래스가 메모리에 처음 생성되는 시점에는 존재하지 않는다.
     ( nil 상태 )
     
     메모리에 있는 것들이 화면에 올라갈 준비가 되었을 때,
     메모리에 올라가는 변수들이다.
    */
    @IBOutlet weak var labelSomeString: UILabel!
    
    // viewDidLoad : 화면에 올라갈 준비가 된 시점
    /*
     때문에 변수를 놓고, 여기서 Instance Property 방식으로 보내준 데이터를 UI에 붙이는 작업을 처리하는 것이 좋다.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelSomeString.textAlignment = .center
        labelSomeString.text = someString
    }

}
