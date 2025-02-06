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
    let outputBoxOffice = [Movie(rank: "10", movieNm: "테스트", audiCnt: "123")]
    let outputSelectedDate: Observable<String> = Observable("")
    init() {
        print("BoxOfficeViewModel Init")
        inputSelectedDate.bind { date in
            self.convertDate(date: date)
        }
    }
    
    
    private func convertDate(date: Date) {
        let format = DateFormatter()
        format.dateFormat = "yy년MM월dd일"
        let string = format.string(from: date)
        outputSelectedDate.value = string
    }
    
    func callBoxOffice(date: String) {
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key={APIKEY}&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let success):
                dump(success.boxOfficeResult.dailyBoxOfficeList)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    
    
    
}
