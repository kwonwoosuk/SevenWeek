//
//  MarketViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

final class MarketViewModel {
    
    let outputMarket = [Market(market: "예시", korean_name: "Korea", english_name: "English")]
    
    init() {
        print("MarketViewModel Init")
         
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
//    func fetchUpbitMarketAPI() {
//        let url = "https://api.upbit.com/v1/market/all"
//        
//        AF.request(url).responseDecodable(of: ) { response in
//            switch response.result {
//            case .success(let success):
//                
//            case .failure(let failure):
//                
//            }
//        }
//    }
}
