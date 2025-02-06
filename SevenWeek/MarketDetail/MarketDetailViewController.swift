//
//  MarketDetailViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/6/25.
//

import UIKit

class MarketDetailViewController: UIViewController {

    
    let viewModel = MarketDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        viewModel.outputOneMarket.bind { [weak self] market in
            print("outputOntMarket bind")
            self?.navigationItem.title = market
        }
        
    }
    // self -> [weak self] -> self?
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("MarketDetailViewController disappear") // 사라졌다고 해서 메모리 가 정리된게 아니라 deinit이 되어야 정리가 된것이다🔴
    }
    
    deinit {
        print("MarketDetailViewController deinit")
    }
}

extension MarketDetailViewController {
    private func configureView() {
        view.backgroundColor = .gray
    }
}
