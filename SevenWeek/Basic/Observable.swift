//
//  Observable.swift
//  SevenWeek
//
//  Created by 권우석 on 2/4/25.
//

import Foundation


class Observable<T> {
    
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
     
    func bind(closure: @escaping (T) -> Void) {
        closure(value)
        self.closure = closure
    }
}
