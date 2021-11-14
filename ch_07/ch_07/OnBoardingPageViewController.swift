/*
 GUI 없이 하는법을 알려주신다네요.
 
 */

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    // 1. 여러개의 페이지를 닮을 array가 필요하다.
    
    var pages = [UIViewController]()
    var bottomButtonMargin: NSLayoutConstraint?
    var pageControll = UIPageControl()
    var currentIndex = 0 {
        didSet {
            pageControll.currentPage = currentIndex
            buttonPresentation()
        }
    }
    
    let startIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemVC1 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        // 에러가 나는 이유는 어,,
        // 설명하자면 긴데, 아무튼 var text = "0" 같이 일반 변수는
        // 인스턴스화 동시에 생성이 되지만,
        // 화면이랑 연동되어 있는 변수는, 화면을 불러오고 연결되는 시간이 있어서
        // 없는 상태일 수 있기 때문에 에러가난다.
        // 그래서 @IBOutlet 어노테이션이 붙어있는 것이다.
//        itemVC1.titleLabel.text = "First"
        itemVC1.topImage = UIImage(named: "on_board_1")
        itemVC1.titleText = "Accelerate productivity of new hires from day one and ensure their growth with Empxtrack employee onboarding software"
        itemVC1.descriptionText = "Empower and engage new hires and set them on the right track for growth. Empxtrack brings the best employee onboarding software to offer a smooth transition for new hires. Schedule your demo today."
        
        let itemVC2 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC2.topImage = UIImage(named: "on_board_2")
        itemVC2.titleText = "Smooth employee onboarding"
        itemVC2.descriptionText = "Empxtrack brings you the best-automated onboarding software that helps streamline and simplify the entire onboarding process. It eliminates manual processes and saves time in onboarding formalities.\n\nOffer a smooth and positive onboarding experience to your new hires that goes beyond welcome emails.\n\nGive your new hires a clarity on company values, mission and help them connect better with the organization’s culture."
        
        let itemVC3 = OnBoardingItemViewController.init(nibName: "OnBoardingItemViewController", bundle: nil)
        itemVC3.topImage = UIImage(named: "on_board_3")
        itemVC3.titleText = "Reduce time-to-productivity with Empxtrack onboarding software"
        itemVC3.descriptionText = "Our employee onboarding software provides all resources to make the journey of new hires stress-free. You can set goals for your employees in the beginning and give them directions to kickstart their work. Get the most effective onboarding tool and save time in employee orientation activities. Our software takes care of all onboarding processes such as:\n\n- Setting up clear work expectations\n- Providing the right tools and environment\n- Aligning employee goals to business objectives\n\nEmpxtrack’s software product speeds up new hires’ onboarding formalities. A notification is flagged to various departments about the new joinee, ensuring they have everything to get the new employees started.\n\nThe new employees can begin working on their goals from day one."
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        /*
         TableView에서 cell에 대한 처리를 연결하기 위해
         delegate, dataSource를 이용한 거 처럼
         PageView에서도 page에 대한 처리를 연결하기 위해
         위와 같이 한다.
         우선은 필요한게 dataSource에만 있어서 이를 구현하도록하겠다.
         */
        
        /*
         처음 시작할 때 나와야 하는 페이지를 지정해줘야 한다.
         기본적으로 애니메이션은 책 넘기는 애니메이션
         */
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
        
        self.makeBottomButton()
        self.makePageControll()
    }

    func makePageControll() {
        self.view.addSubview(self.pageControll)
        pageControll.translatesAutoresizingMaskIntoConstraints = false
        
        // 선택됐을때, 안됐을때,
        pageControll.currentPageIndicatorTintColor = .systemBlue
        pageControll.pageIndicatorTintColor = .lightGray
        pageControll.numberOfPages = pages.count
//        pageControll.currentPage = startIndex
        self.currentIndex = startIndex
        
        // 눌러서 움직이는게 싫다면, 이렇게,
//        pageControll.isUserInteractionEnabled = false
        // 제약사항
//        pageControll.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -80  ).isActive = true
        pageControll.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        pageControll.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        pageControll.addTarget(self, action: #selector(pageControllTapped), for: .valueChanged)
    }
    
    @objc func pageControllTapped(sender: UIPageControl) {
        if sender.currentPage < self.currentIndex {
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true, completion: nil)
        }else {
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
        }
        
        self.currentIndex = sender.currentPage
    }
    
    func makeBottomButton() {
        let button = UIButton()
        
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        // 눌렀다가 올라올때, 이벤트 설정
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        
        self.view.addSubview(button)
        // constraint 설정을 해주기 위해서는 이것을 꺼줘야함.
        button.translatesAutoresizingMaskIntoConstraints = false
//        button.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        // 그 버튼이 없는 아이폰은 밑에 취소 그 바가 있어서
        // 이거를 제외하고 올려줘야함. 알지? 이상하다고 생각했었음
//        button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        // 0이면 constant 옵션 생략가능하다.
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
        
        hideButton()
    }
    
    @objc func dismissPageVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension OnBoardingPageViewController: UIPageViewControllerDataSource {
    /*
     잘보면 변수명이 Before After 인데,
     현재페이지를 기준으로 이전페이지, 다음페이지를 나누는 기준이다.
     */
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // viewController 변수는 현재 페이지를 담고 있다.
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        // 0 인덱스에 대한 에러처리
        // 그대로 나두어도 되지만, 마지막 페이지로 가고싶으면 아래와 같이,
        if currentIndex == 0 {
            return pages.last
        }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // viewController 변수는 현재 페이지를 담고 있다.
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        // 마지막 인덱스에 대한 에러처리
        // 그대로 나두어도 되지만, 마지막 페이지로 가고싶으면 아래와 같이,
        if currentIndex == (pages.count - 1) {
            return pages.first
        }
        return pages[currentIndex + 1]
    }
    
    
}

extension OnBoardingPageViewController: UIPageViewControllerDelegate {
    // 페이지 이동이 끝났을 때 실행되는 이벤트
    // 아래에 Debug View Hierarchy 로 미리 보기 화면 확인 가능
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        // 이 친구는 dataSource처럼 가지고 있지 않다. page를
        // 때문에 pageViewController에 첫번째에 담겨져 있는데
        // 이를 이용한다. Carousel 돌릴 때 느낌
        guard let currentVC = pageViewController.viewControllers?.first else {
            return
        }
        
        guard let currentIdx = pages.firstIndex(of: currentVC) else {
            return
        }
        
        self.currentIndex = currentIdx
//        if currentIdx == pages.count - 1 {
//            // show button
//            showButton()
//        } else {
//            // hide button
//            hideButton()
//        }
//
//        // animation
////        UIView.animate(withDuration: 0.5) {
////            self.view.layoutIfNeeded()
////        }
//
//        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
//            self.view.layoutIfNeeded()
//        }, completion: { UIViewAnimatingPosition in
//            // 포지션이라는 개념이 있어서 좋다.
//            // 하지만 일단 nil ㅋ
//        })
    }
    
    func buttonPresentation() {
        if currentIndex == pages.count - 1 {
            // show button
            showButton()
        } else {
            // hide button
            hideButton()
        }
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func showButton() {
        bottomButtonMargin?.constant = 0
    }
    
    func hideButton() {
        bottomButtonMargin?.constant = 100
    }
}
