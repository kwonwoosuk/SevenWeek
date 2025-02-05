//
//  LoginViewModel.swift
//  SevenWeek
//
//  Created by 권우석 on 2/5/25.
//

import Foundation

class LoginViewModel {
    
    // 실시간으로 달라지는 텍스트필드의 값을 전달 받아옴
    let inputID: Field<String?> = Field(nil)
    let inputPassword: Field<String?> = Field(nil)
    // 텍스트만 레이블로 보내기
    let outputValidText = Field("")
    // 버튼 enabled 관리
    let outputValidButton = Field(false)
    init() {
        
        inputID.bind { text in
            print("inputID Bind")
            self.validation()
        }
        
        inputPassword.bind { _ in
            print("inputPassword Bind")
            self.validation()
        }
    }
    // 매개변수를 생략하나거나 하나더 추가 하거나
    func validation() {
        guard let id = inputID.value ,
              let pw = inputPassword.value else {
            outputValidText.value = "nil입니다"
            outputValidButton.value = false
            return
        }
        
        if id.count >= 4 && pw.count >= 4{
            outputValidText.value = "잘했어요"
            outputValidButton.value = true
        } else {
            outputValidText.value = "아이디는, 비밀번호 4글자 이상입니다."
            outputValidButton.value = false
        }
    }
    
    
    
}
