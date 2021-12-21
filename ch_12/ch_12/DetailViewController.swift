//
//  DetailViewController.swift
//  ch_12
//
//  Created by formegusto on 2021/12/21.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // 다시 색을 바꾸고 싶은 경우
        // 뒤 쪽의 navigationController의 색도 바꿔준다.
        /*
        self.navigationController?.navigationBar.backgroundColor = .systemRed
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.statusBarView.backgroundColor = .systemRed
         */
        self.navigationController?.navigationBar.backgroundColor = .systemRed
        self.statusBar?.backgroundColor = .systemRed
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        /*
//        self.navigationController?.navigationBar.backgroundColor = .systemBlue
//        
//        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//        sceneDelegate?.statusBarView.backgroundColor = .systemBlue
//         */
//        // self.statusBar?.backgroundColor = .systemBlue
//    }
}


// 아무곳에서나 사용하기
extension UIViewController {
    var statusBar: UIView? {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        let window = UIApplication.shared.windows.filter{ $0.isKeyWindow }.first
        if let hasStatusBar = sceneDelegate?.statusBarView {
            window?.addSubview(hasStatusBar)
        }
        
        return sceneDelegate?.statusBarView
    }
}
