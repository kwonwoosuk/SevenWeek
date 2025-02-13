//
//  AppDelegate.swift
//  SevenWeek
//
//  Created by 권우석 on 2/3/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Notification 1. 알림 권한 설정 -> 2. 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in //  허용했을때 아닐때 어떻게 할건지 정하는곳 (컴플리션 핸들러)
            print(success, error)
        }
        
        // 사용자의 권한 상태를 체크해서 대응하는 것도 필요할 수 있음 (필요한 경우)
        
        //NOtification 2. 포그라운드 알림 수신을 위한 delegate설정
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //Notification 2. 포그라운드 수신
    // ex. 친구랑 1대1 채팅하는 경우 당사자는 푸시 안옴. 다른 단톡방/ 갠톡방 등만 푸시가 오는 것처럼 특정 화면 / 조건에 대해서 포그라운드 알람을 받는 것이 가능⭐️
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 메서드가 작성이 되어 있지 않다면 아무것도 안할 것이라는 것을 의미한다
        completionHandler([.badge, .banner, .list, .sound])
    
    }
    //  알람을 사용자가 클릭 했는지 알 수 있는 메서드
    // ex 딸기 상품 페이지로 이동 , 혹은 카카오톡 채팅방이동                                  ↓ response 이친구가 갖고 있는것 중에 notification이라는 프로퍼티가 request로 접근하면 그안에 identifier얻을 수 있음
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(#function) // 알림이 몇개가 전달되었는지는 모르겠지만 사용자가 알림을 클릭 한건지는 알 수 있당
        print(response.notification.request.content.title)
        print(response.notification.request.content.subtitle)
        print(response.notification.request.content.userInfo)
        print(response.notification.request.content.userInfo["type"] as? Int)
        
    }
}

