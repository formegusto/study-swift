//
//  SceneDelegate.swift
//  ch_12
//
//  Created by formegusto on 2021/12/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    // 공통적으로 들어가는 부분은 이제 여기에 적용
    var statusBarView = UIView()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 앱에 가장 화면이 먼저 시작되는 부분.
        /* iOS Multiple Window https://developer.apple.com/design/human-interface-guidelines/ios/system-capabilities/multitasking/
        */
        
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        // statusBar 크기 가지고 오기
        statusBarView.backgroundColor = .systemBlue
        statusBarView.frame = window?.windowScene?.statusBarManager?.statusBarFrame ?? .zero
        
        // View Hierarchy로 보면, UIWindowScene 위에 해당 view가 올라가고,
        // 그 위에 UINavigationView 그리고 ViewController의
        // 하얀색 배경이 깔리면서 색이 가려지는 것을 볼 수가 있다.
        // 그래서 올리는 것을 후에 해야함 모든 화면이 뜬 이후에 해야 한다.
        // window?.addSubview(statusBarView)
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

