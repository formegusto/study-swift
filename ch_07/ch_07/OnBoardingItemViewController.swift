//
//  OnBoardingItemViewController.swift
//  ch_07
//
//  Created by formegusto on 2021/11/14.
//

import UIKit

class OnBoardingItemViewController: UIViewController {
    
    var titleText = ""
    var descriptionText = ""
    var topImage: UIImage? = UIImage()

    // 어짜피 외부에서 값 변경할 일이 없기 때문에
    // private 설정
    @IBOutlet weak var itemView: UIView!
    @IBOutlet private weak var topImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
    @IBOutlet private weak var descLabel: UILabel! {
        didSet {
            self.descLabel.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 메모리에 올라가는 시점에서 변수 설정
        self.topImageView.image = topImage
        self.titleLabel.text = titleText
//        self.descLabel.text = descriptionText
        
        // Line Height 하나하는게 이렇게 힘이드는 일입니다 여러분
        let attrString = NSMutableAttributedString(string: descriptionText)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range:NSMakeRange(0, attrString.length))

        descLabel.attributedText = attrString
    }

}
