//
//  BasicPHPickerViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/4/25.
//

import UIKit
import PhotosUI
class BasicPHPickerViewController: UIViewController {
    
    let pickerButton = UIButton ()
    let photoImageView = UIImageView()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(photoImageView)
        view.addSubview(pickerButton)
        
        photoImageView.snp.makeConstraints { make in
            make.size.equalTo(300)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        
        pickerButton.snp.makeConstraints { make in
            make.width.equalTo(300)
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        photoImageView.backgroundColor = .lightGray
        pickerButton.backgroundColor = .blue
        pickerButton.addTarget(self, action: #selector(pickerButtonClicked), for: .touchUpInside)
    }
    
    @objc
    func pickerButtonClicked() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.screenshots, .images])
        configuration.selectionLimit = 3
        configuration.mode = .default
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    
    
}

extension BasicPHPickerViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        print(#function)
        if let itemProvider = results.first?.itemProvider {
            
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    DispatchQueue.main.async {
                        self.photoImageView.image = image as? UIImage
                    }
                    
                    
                }
            }
        }
        dismiss(animated: true)
        
    }
}
