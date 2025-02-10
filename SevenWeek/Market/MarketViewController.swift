//
//  MarketViewController.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import UIKit
import SnapKit

//final class FavoriteButton: UIButton {
//    init(title: String) {
//        
//    }
//}
final class MarketViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "MarketCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private let viewModel = MarketViewModel()
    
    deinit {
        print("MarketViewController Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraints()
        bindData()
    }
    // VM에서 VC로 바인딩해줄 데이터 뷰모델에서 받아와서 뷰에 실시간 업데이트.
    private func bindData() {
//        vc viewdidload시점에 viewmodel에게 무언가 해달라고 하고싶다
        viewModel.inputViewDidLoadTrigger.value = () // 빈튜플 -> 전달할 수 있는 데이터중 가장 작은 단위?
        viewModel.outputMarket.lazybind { _ in
            print("outputMarket bind")
            self.tableView.reloadData()
        }
        
        viewModel.outputTitle.lazybind { text in
            self.navigationItem.title = text
        }
//         바꿔바..?
        viewModel.outputCellSelected.bind { data in
            print(data) //Optional(()) nil아닌데?
            guard let data else {
                print("nil이라 화면전환 안됨")
                return
            }
            print("22222")
            print(data)
            print("outputCellSelected bind")
            let vc = MarketDetailViewController()
            vc.viewModel.outputOneMarket.value = data.korean_name
            self.navigationController?.pushViewController(vc, animated: true)
//            self.navigationController?.pushViewController(EmptyViewController(), animated: true)
        }
       
        

    
    }
}

extension MarketViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputMarket.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MarketCell", for: indexPath)
        let data = viewModel.outputMarket.value[indexPath.row]
        cell.textLabel?.text = "\(data.korean_name) | \(data.english_name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        let data = viewModel.outputMarket.value[indexPath.row]
        viewModel.inputCellSelected.value = data // 넘겨줄것
    }
    
}

extension MarketViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
    }
}

extension MarketViewController {
    
    private func configureView() {
        navigationItem.title = "마켓 목록"
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
