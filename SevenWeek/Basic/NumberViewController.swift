//
//  NumberViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/5/25.
//

import UIKit
import SnapKit
// 옵져버블
// 1. init
// 2. didSet 값이 리로드되는것처럼 업데이트를 할 수 있다
// 3. closure를 통해 didSet 구현
// 초기 값을 출력하지 못하는게 아쉽다
// 4. init에 값이 들어왔을때 -> 초기값일때도 실행을해보고 싶은 것
class Field<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    // bind에 작성한 구문이 바로 동작하게끔 하고 싶은 경우
    func bind(closure: @escaping (T) -> Void) {
        closure(value) // -> didSet으로 인식해서 closure?(name)가 실행되는게 아니라 bind에서 name을 입력받은뒤  bind에 정의한 클로저가 실행되는것 이 구문이 없으면 처음에 Bind가 실행되지 않는다
        self.closure = closure
    }
    
    func lazybind(closure: @escaping (T) -> Void) {
        // init 안함
        self.closure = closure
    }
}



class NumberViewController: UIViewController {
    
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "값을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let viewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
        //바뀌면 어쩔거야가 bind -> didSet을 생각
        
        viewModel.outputText.bind { text in
            print("outputText:", text)
            self.formattedAmountLabel.text = text
        }
        
        viewModel.outputTextColor.bind { color in
            self.formattedAmountLabel.textColor = color ? .blue : .red
        }
    }
    // 근데 이걸 ui그리기 바쁜 내가 해야겐냐?
    @objc private func amountChanged() {
        print(#function)
        // 공백인경우 -> 값을 입력을 해주세요
        // 문자를 기입했을 경우 -> 숫자를 입력해주세요
        // 숫자의 범위가 너무 크거나 작은경우 - 범위 설정 100만원 이하의 값을 작성해주세요
        // 올바른 값 -> 콤마단위로 표현  1,234,567
        viewModel.inputField.value = amountTextField.text
    }
}

extension NumberViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
    }
    
    private func configureConstraints() {
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }
    
    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }
    
}
