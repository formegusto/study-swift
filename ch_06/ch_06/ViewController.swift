//
//  ViewController.swift
//  ch_06
//
//  Created by formegusto on 2021/11/12.
//


/*
 Segmented Controll
 - Segment 부분 설정해주면 개수 설정이 가능하다.
 */
import UIKit

enum DragType {
    case x;
    case y;
    case none;
}

class ViewController: UIViewController {

    var limitedView = DraggableView()
    var dragType = DragType.none
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let myView = DraggableView()
//        // 초기 위치 및 얼마나 떨어뜨릴 건지, 크기 설정
//        myView.center = self.view.center
//        myView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
//        myView.backgroundColor = .red
//        
//        self.view.addSubview(myView)
        
        limitedView.center = CGPoint(x: self.view.center.x, y: 180)
        limitedView.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        limitedView.backgroundColor = .orange
        self.view.addSubview(limitedView)
        
    }
    
    @IBAction func selectPanType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                dragType = .x
            case 1:
                dragType = .y
            default:
                break
        }
        limitedView.dragType = self.dragType
    }
    

}

