import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var finishLabel: UILabel!
    
    // Dispatch Queue
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Timer
        // setInterval
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: {timer in self.timerLabel.text = Date().timeIntervalSince1970.description})
    }

    @IBAction func action1(_ sender: Any) {
        // 이렇게 단순하게 쓰면 그냥 mainThread 에서 작동이 된다.
        // finishLabel.text = "끝"
        
//        simpleClosure {
//            self.finishLabel.text = "끝"
//        }
        
        simpleClosureAnotherThread {
            self.finishLabel.text = "끝"
        }
    }
    
    func simpleClosure(completion: () -> Void) {
        // 잠깐 멈출뿐 여전히 mainThread 인 것은 변함 없다.
        // 즉, 화면이 Lock이 걸린다.
        // 그래서 Thread를 하나 더 만들어야 한다.
        for idx in 0..<10 {
            Thread.sleep(forTimeInterval: 0.1)
            print(idx)
        }
        completion()
    }
    
    func simpleClosureAnotherThread(completion: @escaping () -> Void) {
        // 일반적인 함수처럼 사용하면 UI의 내용을 변경하는 것은
        // mainThread에서 진행해야 된다고 에러가 발생한다.
        DispatchQueue.global().async {
            for idx in 0..<10 {
                Thread.sleep(forTimeInterval: 0.1)
                print(idx)
            }
            // 그래서 여기서 global이 아닌, DispatchQueue의
            // main 함수를 건든다.
            // completion()
            // 혹은 이를 사용할 때 아래와 같이 사용한다.
            /*
             simpleClosureAnotherThread {
                 DispatchQueue.main.async {
                    self.finishLabel.text = "끝"
                 }
             }
             */
            // 이게 이렇게 동작하는 이유는 복잡하지만,
            // UI에 변화를 주기 위해서는 순서대로 딱딱딱 진행되어야 하는데,
            // mainThread에서 이를 관리한다.
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    @IBAction func action2(_ sender: Any) {
        let dispatchGroup = DispatchGroup()
        let queue1 = DispatchQueue(label: "q1")
        
        // async
        // async는 끝나는 것을 기다리지 않고,
        // 실행 후에 다음것을 바로 실행한다.
        // 하지만, 이는 위와 같은 개념으로 실행이 되지 않을 것 이다.
        // 이는 Thread, Queue의 특징인데, 이번것이 끝나야 다음것을
        // 실행할 수 있다는 규칙때문이다.
        queue1.async(group: dispatchGroup) {
            DispatchQueue.global().async {
                // 이렇게 구성하면 작업자를 하나 더 만든 것과 같다.
                // 대부분 시간이 길게 소요될 거 같은 작업들
                // 1. 이미지 해상도 조절
                // 2. 네트워크 작업
                // 의 경우에는 해당 쓰레드가 락이 걸리지 않도록 이렇게 구성한다. [ 검색 : example_1 ]
                for idx in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print("별도 q1",idx)
                }
            }
            for idx in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(idx)
            }
        }
//        queue1.async(group: dispatchGroup) {
//            for idx in 10..<20 {
//                Thread.sleep(forTimeInterval: 0.2)
//                print(idx)
//            }
//        }
//        queue1.async(group: dispatchGroup) {
//            for idx in 20..<30 {
//                Thread.sleep(forTimeInterval: 0.2)
//                print(idx)
//            }
//        }
        
        // 그래서 여러 작업을 동시에 하고 싶다면 작업자를 여러개 생성한다.
        let queue2 = DispatchQueue(label: "q2")
        let queue3 = DispatchQueue(label: "q3")
        
        queue2.async(group: dispatchGroup) {
            for idx in 10..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(idx)
            }
        }
        queue3.async(group: dispatchGroup) {
            for idx in 20..<30 {
                Thread.sleep(forTimeInterval: 0.2)
                print(idx)
            }
        }
        
        // 그룹안의 모든 큐들의 작업이 끝냈음을 알 수 있는 로직
        dispatchGroup.notify(queue: DispatchQueue.main) {
            print("끝")
        }
        
        // [ example_1 ]
        // 이런경우 던지고 던지고 던지고 하기 때문에 작업이 없는 것 처럼
        // 보여져서 DispatchGroup.notify가 실행된다.
        // QoS로 우선순위를 정할 수도 있다.
        
        // 우선순위의 개념
        // 우선순위가 높다는 것은 금방 실행된다. 하지만 CPU 성능에 따라 달라짐
        queue1.async(group: dispatchGroup, qos: .background) {
            // 그래서 작업이 시작됨을 Group에 알리고 enter()
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for idx in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print("qos back",idx)
                }
                // 작업이 끝났음을 또 알린다. leave()
                dispatchGroup.leave()
            }
        }
        queue2.async(group: dispatchGroup, qos: .userInteractive) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for idx in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print("qos interactive",idx)
                }
                dispatchGroup.leave()
            }
        }
        queue3.async(group: dispatchGroup) {
            dispatchGroup.enter()
            DispatchQueue.global().async {
                for idx in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(idx)
                }
                dispatchGroup.leave()
            }
        }
    }
    
    @IBAction func action3(_ sender: Any) {
        let queue1 = DispatchQueue(label: "q1")
        let queue2 = DispatchQueue(label: "q2")
        
        // sync 라는 함수는
        // 내가 작업을 끝낼 때 까지 다른 쓰레드는 아무 작업도 못하게 한다.
        queue1.sync {
            for idx in 10..<20 {
                Thread.sleep(forTimeInterval: 0.2)
                print(idx)
            }
            queue2.sync {
                for idx in 30..<40 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(idx)
                }
            }
            // Error!
            // deadlock -> 상대 작업이 끝날때까지 서로 계속 기다리는 상태
            // 서로 기다리느라 실행을 못하고 있는 것
//            queue1.sync {
//                for idx in 10..<20 {
//                    Thread.sleep(forTimeInterval: 0.2)
//                    print(idx)
//                }
//            }
            // 때문에 아래와 같은 문법은 말이 안된다.
//            DispatchQueue.main.sync {
//                  main Thread는 돌고 있는 상태인데 돌리려고 하니까 에러
//            }
            // 그래서 sync 는 이 작업이 끝나기 전까지 아무것도 실행되면 안대!
            // 하는 상황에서 쓰인다.
        }
        queue2.sync {
            for idx in 20..<30 {
                Thread.sleep(forTimeInterval: 0.2)
                print(idx)
            }
        }
    }
}

