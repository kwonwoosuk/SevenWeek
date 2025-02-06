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
        viewModel.outputOneMarket.bind { market in
            print("outputOntMarket bind")
            self.navigationItem.title = market
        }
        
    }
}

extension MarketDetailViewController {
    private func configureView() {
        view.backgroundColor = .gray
    }
}
