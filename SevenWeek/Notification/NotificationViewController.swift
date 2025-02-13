//
//  NotificationViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/13/25.
//
/*
 - Notification 관련 정책
 - ForeGround에서는 알림이 뜨지 않는 것이 default
 - ForeGround에서 알림을 받고 싶은경우 , 별도 설정 (delegate) 필요
 - TimeINterval 기반 반복은 60초 이상 부터 사용가능
 - 알림센터에 알림 스택 기준은 identifier 각 알림의 고유 값을 의미 한다
 - 뱃지 숫자는 알림 갯수와 무관 일일이 관리 해주어야함
 10 -> 9개 -> 2개 클릭 된것만 알 수 있음
 
 - 알림 센터에 보이고 있는지 사용자에게 전달되었는지 알 수 없음
 - 단, 사용자가 알람을 "클릭" 했을때만 확인(delegate)
 - identifier: 고유값 / 64개 제한
 
 - 디데이... 앱에서 다시 실행해달라는 알림이 오는데 이유는 고유값이 64개만 제공되기 때문이다..
 
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
        content.title = "테스트 userinfo 활용"
        content.subtitle  = "\(Int.random(in: 1...10000))"
        content.badge = 100 //  쌓여있던 뱃지가 사라지도록 할 수 있게 하려면 0 을 대입 하면 된다.
        // userinfo활용
        content.userInfo = ["type": 2, "id": 45623]
        
        // 반복이 왜 필요할까?
        // 1) 시간 간격 2) 캘린더 기반 3) 위치 기반
        let trigger =  UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false) //  시간 반복 간격 설정해서 반복적으로 알림 줄 수있음 // 시간 기반
        // 이제는 캘린더 기반으로 알림을 줘보자 !
        var components = DateComponents()
        //        components.day = 14
        //        components.hour = 11
        components.minute = 18 // 18분에 반복됨
        
        // 두달치를 미리 등록해놓고 싶은거임
        for item in 1...70 { // 64개 까지만 보임 / 앱 당 64개로 제한되어 있음
            let request = UNNotificationRequest(identifier: "suk\(item)", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request) { error in // 알림시스템에 등록
                print(error)
            }
        }
        
        
        
        //        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false) // 캘린더 기반
        //        let request = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: trigger)
        
        //        UNUserNotificationCenter.current().add(request) { error in // 알림시스템에 등록
        //            print(error)
        //        }
    }
    
    
}
