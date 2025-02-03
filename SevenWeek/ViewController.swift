//
//  ViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/3/25.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

class ViewController: UIViewController {
    
    // 1. 위치 매니저 생성 : 위치에 관련된 대부분을 담당 -- 패턴이다 누굴 쓰더라도 대부분 매니저가 있다
    lazy var locationManager = CLLocationManager()
    let locationButton = UIButton()
    let mapView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
       
        
        NetworkManager.shared.getLotto3 { response in
            switch response {
            case .success(let success):
                <#code#>
            case .failure(let failure):
                <#code#>
            }
        }
//        NetworkManager.shared.getLotto2 { lotto, error in
//            
//            // 1. 얼리 엑싯 됨  성공하는 케이스 없음
//            guard let lotto = lotto
//                    , let error = error else {
//                return
//            }
//            
//            // 2. 문제로또
//            // 로또 존재 에러 닐 -> 문제 안됨
//            // 로도 닐 에러 존재 -> 에러 실행 안됨 앱 터짐
//            guard let lotto = lotto else {
//                return
//            }
//            guard let error = error else {
//                return
//            }
//        }
        
        
        
        checkDeivceLocation() // lazy var locationManager = CLLocationManager() lazy로 선언하면 두번 호출 되게 되는데 /locationManagerDidChangeAuthorization이 친구의 실행조건이 // 사용자의 권한 상태가 변경될때, locationManager 인스턴스가 생성이 될때 실행되기 때문에 lazy로 선언하면 ViewDidload에서 메서드 실행을 안해줘도 된다 !! (선택사항)
        
        // 3. 위치 프로토콜 연결
        locationManager.delegate = self
        
        view.addSubview(mapView)
        view.addSubview(locationButton)
        
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
        locationButton.backgroundColor = .red
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        mapView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        
    }
    
    @objc
    private func locationButtonClicked() {
        checkDeivceLocation()
        // 현재 위치를 가져오는 단순한 기능이여도 그사이에 권한을 바꿨을 수 있다  - > 모든 예외사항 처리
        // 가급적 새로 요청할때 권한을 갖고 있는지 확인하는게 좋을 수 있다 
    }
    
    
    // 얼럿: 아이폰의 시스템 위치 서비스가 켜져있는지 체크 -> 권한 허용 얼럿 (약간의 조건문이 들어갈 수 있다)
    private func checkDeivceLocation() {
        
        print(Thread.isMainThread)
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                // 현재 사용자의 위치 권한 상태확인
                // if  허용된 상태 -> 권한 얼럿 띄울필요 X
                // if  거부한 상태 -> 아이폰 설정으로 이동
                // if notDetermined -> 권한 설정 띄워주기
                print(self.locationManager.authorizationStatus)
                
                
                DispatchQueue.main.async {
                    self.navigationItem.title = "asdfadsff"
                    self.checkCurrentLocation()
                }
                
                // info.plist 에서 설정 한것과 동일해야됨 엑코에서 말 안해줌  찾기 어려움
                self.locationManager.requestWhenInUseAuthorization()
                
            } else {
                DispatchQueue.main.async {
                    print("위치 서비스가 꺼져 있어 위치권한을 요청할 수 없습니다 ") //  실제로 얼럿과 시스템 설정으로 유도하는 구현 필요
                }
            }
        }
    }
    
    private func checkCurrentLocation() {
        let status = locationManager.authorizationStatus
        
        switch status {
        case .notDetermined: //  미결정
            print("이 권한에서만 문구 띄울 수 있음")
            
            locationManager.requestWhenInUseAuthorization() // 얘만 불러도 축소버전인 한번만 허용 뜨게 되어있음
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            
        case .denied: // 거부
            print("설정으로 이동하는 얼럿 띄우기")
            
        case .authorizedWhenInUse: // 앱을 사용하는 동안 허용
            print("정상 로직 실행")
            locationManager.startUpdatingLocation() //  이제 gps 가져 오시면 됩니당~ 요이땅 ~
        default:
            print("오류 발생")
            
        }
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
    }
    
    
}


// 2. 위치 프로토콜 선언 -- 헬스킷이나 카메라 킷도 동일하게 동작한다
extension ViewController: CLLocationManagerDelegate {
    
    //-> 동서남북 같은거
    //    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
    //        <#code#>
    //    }
    // 사용자의 위치를 성공적으로 가지고 온경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function)
        print(locations) // 전체출력 - 결과가 배열이다
//        print(locations.last?.coordinate) // coordinate == 좌표
        // 위도 , 경도
        // 날씨 정보를 호출 하는 API
        // 지도를 현재위치 중심으로 이동시키는 기능
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        } else {
            //위치 없스면 ~
        }
        // start를 했다면 더이상 위치를 안받아와도 되는 시점에 stop을 외쳐야해요! -> 날씨 불러오는거
        // 러닝같은경우는 계속 요청을 해야겠구용
        locationManager.stopUpdatingLocation()
    }
    // 사용자의 위치를 성공적으로 가지고 오지 못한경우
    // ex: 사용자가 위치 권한을 거부한 경우, 가족 권한-> 부모가 권한을 제어한 경우 상태가 바뀔 수 없음 <- 자녀보호 기능 / 위치 서비스 자체가 꺼져있는 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
    }
    
    
    
    // 사용자의 권한 상태가 변경될때, locationManager 인스턴스가 생성이 될때 실행됨
    // ex: 허용했었지만 시스템에서 허용안함으로 바꾸는 경우
    // iOS14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeivceLocation()
    }
    
    // iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
    }
}
