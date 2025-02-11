//
//  NasaViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/11/25.
//

import UIKit
import SnapKit


enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}

final class NasaViewController: UIViewController {
    
    
    let requestButton = UIButton()
    let progressLabel = UILabel()
    let nasaImageView = UIImageView()
    // 총데이터의 양
    var total: Double = 0
    // 현재 진행중?
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100) / 100"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        buffer = Data()
    }
    
    func configureHierarchy() {
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(nasaImageView)
    }
    
    func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
        
    }
    
    func configureView() {
        view.backgroundColor = .white
        requestButton.backgroundColor = .blue
        progressLabel.backgroundColor = .white
        progressLabel.text = "100% 중 35.5% 완료"
        nasaImageView.backgroundColor = .systemBrown
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    
    @objc
    func requestButtonClicked() {
        print(#function)
        
        buffer = Data()
        
        callRequest()
    }
    
    func callRequest() {
        let request = URLRequest(url: Nasa.photo, timeoutInterval: 5) // 사용자가 기다릴시간
        let configuration = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main)
        
        configuration.dataTask(with: request).resume()
        
    }
}

extension NasaViewController: URLSessionDataDelegate {
    //상태코드
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            
            
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length") else {
                return .cancel
            }
            
            total = Double(contentLength)!
            
            return .allow
        } else  {
            return .cancel
        }
    }
    
    //서버에서 데이터를 받아올때 마다 반복적으로 호출
    //실질적인 데이터 !!
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer?.append(data)
    }
    // 응답이 완료되었을떄 호출
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            progressLabel.text = "문제가 생겼다요"
        } else {
            //completionHanlder 시점과 사실 상 동일
            // buffer -> Data -> Image
            guard let buffer = buffer else {
                print("buffer없음")
                return
            }
            
            let image = UIImage(data: buffer)
            nasaImageView.image = image
        }
    }
}
