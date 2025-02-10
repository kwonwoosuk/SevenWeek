//
//  BaseViewModel.swift
//  SevenWeek
//
//  Created by 권우석 on 2/10/25.
//

import Foundation


// generic: 호출 시 타입결정. T 타입 파라미터
// 연산에 따라 제약 조건을 걸어야 할 수 있음









//protocol에서 제네릭은 associatedType을 사용한다 T 사용안함
protocol BaseViewModel { // 인터페이스라고 불린다 !
    //    struct Input { }
    associatedtype Input
    //    struct Output { } // 제네릭 타입처럼 너네둘을 쓰겠다 이거야 !
    associatedtype Output
    
    func transform()
}


protocol Mentor {
    associatedtype Jack
    func hello(a: Jack)
}

class Test: Mentor {
    typealias Jack = String
    
    func hello(a: Jack) {
        print(a)
    }
    // 왜 생략이 가능한건지 설명할 수 있는게 좋을것 같다
    
    
    
}

// 구체적으로 명세할 경우 typealias 필요없음
//typealias Jack = sesac
//typealias T = bran
//// 규칙을 잘 지켜서 사용하거나
//// 구체적으로 명세하지 않는다면 typealias로 별칭 설정
//// -> 프로토콜에서 제네릭을 사용하는 방법⭐️
//
//
//class bran {
//
//}
//
//struct sesac {
//
//}
class Sample: BaseViewModel {
    typealias Input = Jack // Input이 누구인지만 알려주면 사용할 수 있다 !
    
    
    struct Jack {
        
    }
    
    struct Output {
        
    }
    
    func transform() {
        
    }
    
    
}
