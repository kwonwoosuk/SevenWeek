//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire
class BoxOfficeViewModel {
    
    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let selectedDate: Observable<Date> = Observable(Date())//오늘날짜 집어넣어주 기본값으로
        let searchButtonTapped: Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let boxOffice: Observable<[Movie]> = Observable([])
        let selectedDate: Observable<String> = Observable("")
        // 전달하려는건 아니고 다른 메서드에 파라미터로 쓰려고 하는거라 옵져버블로 굳이 선언하지 않고 private으로 뷰모델안에서 선언
    }
    
    private var query = "" // 이렇게 따로 두어도 괜찮다
    
    init() {
        
        print("BoxOfficeViewModel Init")
        input = Input()
        output = Output()
        
        transform()

    }
    
    private func transform() {
        input.selectedDate.bind { date in
            self.convertDate(date: date)
        }
        //value에 대해 메모리값이 완전히 동일해서 didSet이 동작이 안할 수 있겠다는 결론이 나올 수도있다.
        input.searchButtonTapped.bind { _ in
            self.callBoxOffice2(date: self.query)
            print("-----", self.query)
        }
        
        
    }
    
    
    private func convertDate(date: Date) {
        let format = DateFormatter()
        format.dateFormat = "yy년MM월dd일"
        let string = format.string(from: date)
        output.selectedDate.value = string
        
        
        let format2 = DateFormatter()
        format2.dateFormat = "yyyyMMdd"
        let query = format2.string(from: date)
        self.query = query
    }
    
    private func callBoxOffice2(date: String) {
        print(#function)
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key.kofic)&targetDt=\(date)"
        
        
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession(configuration: .default)
        
        
        
        // 네트워크 환경을 구성을 하겠다
        //        URLSession.shared.dataTask(with: request) { data, response, error in
        //            print("--Data--", data) // 실질적인 데이터 부분 json도 아니고 구조체로 바뀌지도 않은것 바꿔주는 과정이 필요함
        //            print("--response--", response) //  상태 코드에 대한 부분
        //            print("-error--", error) //
        //            //Data?
        //            //URLResponse?
        //            //Error?
        //        }.resume() // 시작을 알리는 친구 없인 통신조차 시켜주지 않어
        print("1----:\(Thread.isMainThread)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            print("2----:\(Thread.isMainThread)")
            if let _ = error { // 에러 있으면 중단 
                print("오류발생")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("상태코드 대응")
                return
            }
            // 0101로 구성되어 있던 Data타입을 디코딩 해줘야 한다
            
            if let data = data, let movieData = try? JSONDecoder().decode(BoxOfficeResult.self, from: data) {
                dump(movieData)
                self.output.boxOffice.value = movieData.boxOfficeResult.dailyBoxOfficeList
            } else {
                print("data가 없거나 movie decoding을 실패했음")
                return
            }
            
            
            
        }.resume()
        
    }
    
    private func callNasaAPI() {
        
    }
    
    
    private func callBoxOffice(date: String) {
        
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key.kofic)&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result { //  response
            case .success(let success): //  data
                self.output.boxOffice.value = success.boxOfficeResult.dailyBoxOfficeList
                print("----callBoxOffice----")
            case .failure(let failure): //  error
                print(failure)
            }
        }
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    
    
    
}

