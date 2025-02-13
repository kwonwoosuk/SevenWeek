//
//  SceneDelegate.swift
//  SevenWeek
//
//  Created by 권우석 on 2/3/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: NotificationViewController())
        window?.makeKeyAndVisible()
        
        
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    
    // - 다시 앱을 실행 헀을때 뱃지를 제거 하고 싶다면 이 시점을 활용할 수있다 정도 ! 여기서 해야한다!가 아니다.⭐️
    func sceneDidBecomeActive(_ scene: UIScene) {
        //Badge 제거
//        UIApplication.shared.applicationIconBadgeNumber = 0 deprecated됨
        UNUserNotificationCenter.current().setBadgeCount(0)
        // 사용자에게 전달되어 있는  알람제거 (default로는 알람을 클릭해서 열어주어야 그 알람만 제거됨!)
        
//        UNUserNotificationCenter.current().removeAllDeliveredNotifications() // 이미 사용자에게 전달되어 플로팅된 알람을 제거를 해야겠다 !
        // pending 대기중 / 보류
        // 미리 알림같은 예정된 알림 같은것을 지울때 사용할 수 있겠다 
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // 모든 팬딩이 되는 요청을 지우겠다 -> 사용자에게 아직 전달되지 않았지만 앞으로 전달될 알람을 제거
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

