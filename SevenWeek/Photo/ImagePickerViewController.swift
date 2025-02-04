//
//  ImagePickerViewController.swift
//  SevenWeek
//
//  Created by 권우석 on 2/4/25.
//

import UIKit
import SnapKit

class ImagePickerViewController: UIViewController {

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
        print(#function)
        let imagePicker = UIImagePickerController()
         imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
//        imagePicker.sourceType = .camera 실기기 빌드해보기
        
        //UIFontPickerViewController()
        
        present(imagePicker, animated: true)
    }
    
    

}

extension ImagePickerViewController: UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    //사진을 골랐을때 실행되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        //이미지를 선택
        // 이미지뷰에 이미지를 넣는 작업 피커 dismiss
        let image = info[UIImagePickerController.InfoKey.editedImage]
        
        if let result = image as? UIImage {
            photoImageView.image = result
        }
        
        
        dismiss(animated: true)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
}

