//
//  DraggableView.swift
//  ch_06
//
//  Created by formegusto on 2021/11/12.
//
import UIKit

class DraggableView: UIView {
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dragging(pan: UIPanGestureRecognizer) {
        switch pan.state {
        // 누르는 순간
        case .began:
            print("began")
        // 눌러서 움직일 때
        case .changed:
            // 부모 뷰를 기준으로 좌표값
            let delta = pan.translation(in: self.superview)
            
            // 절대좌표가 필요하다.
            // self.center 는 UIView의 가운데 값
            var myPosition = self.center
            myPosition.x += delta.x
            myPosition.y += delta.y
            
            self.center = myPosition
            
            // translation 값을 초기화 안해주면 계속 증감된다.
            // 누르고 있는 상태에서 움직였을 경우,
            pan.setTranslation(CGPoint.zero, in: self.superview)
        // 눌러서 끝났을 때
        case .ended, .cancelled:
            print("ended, cancelled")
            
        default:
            break
        }
    }
}
