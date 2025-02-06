//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire
class BoxOfficeViewModel {
    
    let inputSelectedDate: Observable<Date> = Observable(Date())//오늘날짜 집어넣어주 기본값으로
    let inputSearchButtonTapped: Observable<Void?> = Observable(nil)
    let outputBoxOffice: Observable<[Movie]> = Observable([])
    let outputSelectedDate: Observable<String> = Observable("")
    // 전달하려는건 아니고 다른 메서드에 파라미터로 쓰려고 하는거라 옵져버블로 굳이 선언하지 않고 private으로 뷰모델안에서 선언
    
    
    
    private var query = ""
    
    init() {
        print("BoxOfficeViewModel Init")
        inputSelectedDate.bind { date in
            self.convertDate(date: date)
        }
        //value에 대해 메모리값이 완전히 동일해서 didSet이 동작이 안할 수 있겠다는 결론이 나올 수도있다.
        inputSearchButtonTapped.bind { _ in
            self.callBoxOffice(date: self.query)
            print("-----", self.query)
        }
    }
    
    
    private func convertDate(date: Date) {
        let format = DateFormatter()
        format.dateFormat = "yy년MM월dd일"
        let string = format.string(from: date)
        outputSelectedDate.value = string
        
        
        let format2 = DateFormatter()
        format2.dateFormat = "yyyyMMdd"
        let query = format2.string(from: date)
        self.query = query
    }
    
    private func callBoxOffice(date: String) {
        
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key.kofic)&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let success):
                self.outputBoxOffice.value = success.boxOfficeResult.dailyBoxOfficeList
                print("----callBoxOffice----")
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    
    
    
}

