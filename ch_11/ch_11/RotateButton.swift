//
//  RotateButton.swift
//  ch_11
//
//  Created by formegusto on 2021/12/13.
//

import UIKit

enum RotateType {
    case up
    case down
}

/*
 initializer error의 구조
 */
class MyButton {
    convenience init() {
        self.init(frame: .zero)
        // 반드시 만들어야 하는 부분을 정의
    }
    
    init(frame: CGFloat) {
        
    }
    
    required init(coder: NSCoder) {
        
    }
}

class CustomButton: MyButton {
    init() {
        // error 1. super init
        // super.init()
        // error 2. designated initializer
        super.init(frame: .zero)
    }
    
    // error 3. required init
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RotateButton: UIButton {
    init() {
        super.init(frame: .zero)
        // init(frame:)
        /*
         apple developer document 확인
         대충 반드시 써야한다는 의미. 변형을 해도되지만, 반드시 상위 계층에 init(frame:)을 호출시켜줘야 한다.
         */
        configure()
    }
    
    required init?(coder: NSCoder) {
        // story board에 올린 것은 여기 init이 호출된다.
        // fatalError("init(coder:) has not been implemented")
        super.init(coder: coder)
        configure()
    }
    
    var isUp = RotateType.up {
        didSet {
            changeDesign()
        }
    }
    
    var selectTypeCallback: ((RotateType) -> Void)?
    
    func configure() {
        self.addTarget(self, action: #selector(selectButton), for: .touchUpInside)
    }
    
    @objc private func selectButton() {
        if isUp == .up {
            isUp = .down
        } else {
            isUp = .up
        }
        
        selectTypeCallback?(isUp)
    }
    
    private func changeDesign() {
        UIView.animate(withDuration: 1) {
            if self.isUp == .down {
                self.imageView?.transform = CGAffineTransform(rotationAngle: .pi) // 180도
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(0.3)
            } else {
                self.imageView?.transform = .identity // 원래 값으로 돌아가는 설정
                self.backgroundColor = self.backgroundColor?.withAlphaComponent(1)
            }
        }
    }
}
