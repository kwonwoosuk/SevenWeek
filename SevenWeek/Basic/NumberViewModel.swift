//
//  NumberViewModel.swift
//  SevenWeek
//
//  Created by 권우석 on 2/5/25.
//

import Foundation
// 2월 10일 인아웃 패턴

/*
 viewModel을 통해 UI로직과 비즈니스 로직을 분리
 데이터 가공과 연산 viewModel
 1차적 목표 uikit사용하지 않고 구성할 수 있는거 다 해보자 ~!
 - 비즈니스 로직도 input과 output으로 나눠보자
 
 // MVC에서 MVVM으로 왜 넘어갔냐? (질문) -> 뷰컨의 비대성을 해결하기 위해 도입을헀다 보통 대답 -> 컨트롤러가 비대해지는 것을 뷰모델이 나눠갖는다고 하면 뷰모델도 비대해진는거 아닌가요? ->
 많아지는 코드들을 명확성을 갖게 하기위해 input output 나눠 보는것
 
 
 
 
 */
class NumberViewModel {
    // VC가 VM의 input.output 프로퍼티만 알고있는 상황
    private(set) var input: Input //🔴
    private(set) var output: Output //🔵
    // 선언만 해주었기때문에 초기화 과정이 필요하다
    
    // input에 들어갈 친구는 구조체에 넣는다 1번
    struct Input { //🔴
        // inputField -> field
        var field: Field<String?> = Field(nil)
    }
    
    struct Output { // 중복되는 명칭 지워줌 🔵
        var text = Field("")
        var textColor = Field(false)
    }
    
    // 뷰컨에서 사용자가 받아온 값 그 자체
    //    var inputField = Field("") // 실시간으로 받아온정보를 didset으로 잘 받기위해
    //    var inputField: Field<String?> = Field(nil) => Input구조체로 들어감
    // 뷰컨에 레이블에 보여줄 최종 텍스트
    //    var outputText = Field("") -> 아웃풋 구조체로 들어감
    // 뷰컨에 레이블 텍스트 컬러로 사용 할것 무조건 UIKit임포트 하지말아야하는건 아님 구분을 위해 사용을 말아라 정도
    // 잘한것 파랑 잘못된건 빨강 -> bool값으로 해봐?
    //    var outputTextColor = Field(false) -> 아웃풋 구조체로 들어감
    
    init() {
        print("NumberViewModel")
        
        input = Input()
        output = Output()
        
        transform()
        
    }
    
    private func transform() {
        input.field.bind { text in
            //            print("inputField:", text)
            self.validation()
        }
    }
    
    private func validation() {
        // 1) 옵셔널 핸들링
        guard let text = input.field.value else {
            output.text.value = ""
            output.textColor.value = false
            return
        }
        // 2) Empty
        if text.isEmpty {
            output.text.value = "값을 입력해주세요"
            output.textColor.value = false
            return
        }
        
        // 3) 숫자여부
        guard let num = Int(text) else {
            output.text.value = "숫자만 입력해주세요"
            output.textColor.value = false
            return
        }
        
        // 4) 범위 1 - 1,000,000
        if num > 0, num <= 1000000 {
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            output.text.value = "₩" + result
            output.textColor.value = true
        } else {
            output.text.value = "백만원 이하를 입력해주세요"
            output.textColor.value = false
        } // 로직에 대한 것은 뷰모델에서 하고 아웃풋만 넘겨주면 된다
    }
    
}
