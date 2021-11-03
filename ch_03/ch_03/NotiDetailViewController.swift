//
//  NotiDetailViewController.swift
//  ch_03
//
//  Created by formegusto on 2021/11/03.
//

import UIKit

class NotiDetailViewController: UIViewController {

    @IBAction func notiAction(_ sender: Any) {
        let notificationName = Notification.Name("send some string")
        let strDic = [
            "str": "some string from notification"
        ]
        NotificationCenter.default.post(name: notificationName, object: nil, userInfo:  strDic)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
