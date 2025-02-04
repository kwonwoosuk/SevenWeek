//
//  exampleViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/4/25.
//

import UIKit

class User<T> {
    
    var myFunction: (() -> Void)?
    
    var value: T {
        didSet {
            myFunction?()
        }
    }
        
    
    init(_ value: T) {
        self.value = value
    }
}




class exampleViewController: UIViewController {

    let jack = User("1")
    
    var nickname = "고래밥" {
        didSet {
            print("닉네임: \(nickname)")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        jack.value = 2
//        jack.value = 3
//        (jack.myFunction ?? <#default value#>) {
//            print("닉네임: \(self.nickname)")
//            print("아무기능")
//        }
//        jack.value
//        
//        
        
        
        
        print("닉네임: \(nickname)")
        
        nickname = "칙촉"
        
        nickname = "고구마"
        
        
        
        
        configureView()
        test()
        print("----")
        test2()
    }
    
    
    func test2() {
        var num = Observable(3)
        
        num.bind { value in
            print(value)
        }
        
        num.value = 2
        num.value = 100
    }
    
    
    func test () {
        var num = 3
        
        print(num)
        num = 6
        num = 4
    }
        
    
    
    func configureView() {
        view.backgroundColor = .white
    }
    
}
