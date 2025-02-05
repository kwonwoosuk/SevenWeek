//
//  NumberViewModel.swift
//  SevenWeek
//
//  Created by 권우석 on 2/5/25.
//

import Foundation

class NumberViewModel {
    
    // 뷰컨에서 사용자가 받아온 값 그 자체
    //    var inputField = Field("") // 실시간으로 받아온정보를 didset으로 잘 받기위해
    var inputField: Field<String?> = Field(nil)
    // 뷰컨에 레이블에 보여줄 최종 텍스트 
    var outputText = Field("")
    
    init() {
        print("NumberViewModel")
        
        inputField.bind { text in
            print("inputField:", text)
            self.validation()
        }
    }
    
    func validation() {
        // 1) 옵셔널 핸들링
        guard let text = inputField.value else {
            outputText.value = ""
            return
        }
        // 2) Empty
        if text.isEmpty {
            outputText.value = "값을 입력해주세요"
            return
        }
        
        // 3) 숫자여부
        guard let num = Int(text) else {
            outputText.value = "숫자만 입력해주세요"
            return
        }
        
        // 4) 범위 1 - 1,000,000
        if num > 0, num <= 1000000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            outputText.value = "₩" + result
        } else {
            outputText.value = "백만원 이하를 입력해주세요"
        } // 로직에 대한 것은 뷰모델에서 하고 아웃풋만 넘겨주면 된다
    }
    
}
