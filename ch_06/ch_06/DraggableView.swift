//
//  DraggableView.swift
//  ch_06
//
//  Created by formegusto on 2021/11/12.
//
import UIKit

class DraggableView: UIView {
    var dragType = DragType.none
    
    init() {
        super.init(frame: CGRect.zero)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
    }
    
    // 여기 init : NSCoder 가 붙어있으면, 코드로 만드는 Component가 아닌,
    // StoryBoard, UIInterface 에서 만든 것이다. 때문에 따로 설정해주어야 한다.
    // 협업시, 여기에 에러 설정이 있으면, 이와같이 만들면
    // 안된다는 것이다! 명심명심
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dragging))
        self.addGestureRecognizer(pan)
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
            
            switch dragType {
            case .x:
                myPosition.x += delta.x
            case .y:
                myPosition.y += delta.y
            case .none:
                myPosition.x += delta.x
                myPosition.y += delta.y
                break
            }
            
            
            self.center = myPosition
            
            // translation 값을 초기화 안해주면 계속 증감된다.
            // 누르고 있는 상태에서 움직였을 경우,
            pan.setTranslation(CGPoint.zero, in: self.superview)
        // 눌러서 끝났을 때
        case .ended, .cancelled:
            print("ended, cancelled")
            // minX 시작점 (왼쪽 상위)
            if self.frame.minX < 0 {
                // origin x 는 현재 위치에서의 왼쪽 상위 모서리 위치를 말한다.
                self.frame.origin.x = 0
            }
            
            print(
            )
            
            if self.frame.minY < 100 {
                self.frame.origin.y = 100
            }
            
            if let hasSuperView = self.superview {
                if self.frame.minY < hasSuperView.safeAreaInsets.top + 40 {
                    self.frame.origin.y = hasSuperView.safeAreaInsets.top + 40
                }
                if self.frame.maxX > hasSuperView.frame.maxX {
                    self.frame.origin.x = hasSuperView.frame.maxX - self.bounds.width
                    
                }
                
                if self.frame.maxY > hasSuperView.frame.maxY {
                    self.frame.origin.y = hasSuperView.frame.maxY - self.bounds.height
                }
            }
            
        default:
            break
        }
    }
}
