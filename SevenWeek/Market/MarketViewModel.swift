//
//  MarketViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

final class MarketViewModel {
    
    let outputMarket: Observable<[Market]> = Observable([])
    let outputTitle: Observable<String?> = Observable(nil)
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil) // 뷰디드 시점에 정확히 없다가 나타나는것 처럼 보이도록 하기위함 nil
    
    let inputCellSelected: Observable<Market?> = Observable(nil) // 해줘
    let outputCellSelected: Observable<Market?> = Observable(nil) // 반사~
    
    init() {
        print("MarketViewModel Init")
        inputViewDidLoadTrigger.lazybind { _ in
            print("inputViewDidLoadTrigger bind")
            self.fetchUpbitMarketAPI()
        }
        // 셀선택했을때 뭐해줄거야!?
        //bind로 하면 셀을 선택하지 않아도 outputCellselected에 ()를 넣어줘버린다
        inputCellSelected.lazybind { market in
            print("inputCellSelected bind")
            self.outputCellSelected.value = market
        }
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
    private func fetchUpbitMarketAPI() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
                dump(success)
                self.outputMarket.value = success
                self.outputTitle.value = success.randomElement()?.korean_name
            case .failure(let failure):
                dump(failure)
            }
        }
    }
    
    
}
