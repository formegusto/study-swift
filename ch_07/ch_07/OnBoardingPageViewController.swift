/*
 GUI 없이 하는법을 알려주신다네요.
 
 */

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    // 1. 여러개의 페이지를 닮을 array가 필요하다.
    
    var pages = [UIViewController]()
    
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
        // 마지막 인덱스에 대한 에러처리
        // 그대로 나두어도 되지만, 마지막 페이지로 가고싶으면 아래와 같이,
        if currentIndex == (pages.count - 1) {
            return pages.first
        }
        return pages[currentIndex + 1]
    }
    
    
}
