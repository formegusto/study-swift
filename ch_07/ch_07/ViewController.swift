/*
    OnBoardingView
    - PageViewController 사용법을 다룬다.
    : 첫 인트로 화면을 만들어보면서,
 
    - Layout 잡기 Tip
        // Constraint의 Multiplier 만져주면 위로올라감.
 */

import UIKit

class ViewController: UIViewController {

    // 밑에 친구들의 문제점은 dismiss 해서 현재 페이지가 팝하고 나타날때도 실행된다는 것,
    // 때문에, 상태값을 기억해주는 변수가 필요하다.
    
    var showOnBoardingPage = false
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         에러가 뜰텐데, 뜨는 이유가,
         viewDidLoad는 화면이 띄어질거다~ 라는 의미지 화면이 올라왔다는 의미가 아님,
         정확히는 화면에 쓰는 변수들이 다 메모리에 올라온 시점
         때문에 올라오기전에 이동하려 해서 에러가 남!
         */
//        let itemVC = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
//
//        self.present(itemVC, animated: true, completion: nil)
    }

    /*
     화면이 그려지기 전의 시점 : 여기서도 실행하면 안된다.
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    /*
     화면이 다 그려진 시점,
     화면에 대한 처리가 정상적으로 이루어지려면 반드시
     화면이 다 그려진 후에 해야한다.
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let itemVC = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
//
//        self.present(itemVC, animated: true, completion: nil)
        // XIB가 없어서 그냥 인스턴스화 하면 된다.
        if !showOnBoardingPage {
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
            // get-only property 라 처음에 만들때만 설정가능하다.
    //        pageVC.transitionStyle = .scroll
            pageVC.modalPresentationStyle = .fullScreen
            
            self.showOnBoardingPage = true
            self.present(pageVC, animated: true, completion: nil)
        }
        
    }
}

