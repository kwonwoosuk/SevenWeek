//
//  EmptyViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/6/25.
//

import UIKit

class EmptyViewModel {
    init() {
        print("EmptyViewModel Init")
    }
    
    deinit {
        print("EmptyViewModel deinit")
    }
}



class EmptyViewController: UIViewController {
    
    let viewModel = EmptyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
        print("EmptyViewController ViewDidLoad")
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EmptyViewController viewDidDisappear")
    }
      
    deinit {
        print("EmptyViewController deinit")
    }
}
