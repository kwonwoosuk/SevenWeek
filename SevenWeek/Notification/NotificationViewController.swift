//
//  NotificationViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/13/25.
//
/*
 Notification 관련 정책
 - ForeGround에서는 알림이 뜨지 않는 것이 default
 - ForeGround에서 알림을 받고 싶은경우 , 별도 설정 (delegate) 필요
 
 */

import UIKit
import SnapKit

class NotificationViewController: UIViewController {
    
    let requestButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        configureButton()
    }
    
    func configureButton() {
        view.addSubview(requestButton)
        requestButton.backgroundColor = .blue
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    
    @objc
    func requestButtonClicked() {
        print(#function)
        
        let content = UNMutableNotificationContent()
        content.title = "이것이 로컬알림입니다"
        content.subtitle  = " 서브 타이틀 영역"
        
        let trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false) //  시간 반복 간격 설정해서 반복적으로 알림 줄 수있음
        let request = UNNotificationRequest(identifier: "jack", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print(error)
        }
    }
    
    
}
