//
//  ViewController.swift
//  bookit
//
//  Created by Muazzam.Aziz on 2022/09/27.
//

import UIKit

class PhoneViewController: UIViewController, UITextFieldDelegate {
    
    private let phoneNumberField: UITextField = {
        let field = UITextField()
        field.placeholder = "Phone Number"
        field.textAlignment = .center
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .continue
        return field
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        
    }
    
    func setupAppearance() {
        view.backgroundColor = .systemBackground
        view.addSubview(phoneNumberField)
        phoneNumberField.frame = CGRect(x: 0, y: 0, width: 220, height: 50)
        phoneNumberField.center = view.center
        phoneNumberField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            let number = "+1\(text)"
            AuthenticationManager.shared.startAuth(phoneNumber: number) { [weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let smsViewController = SMSCodeViewController()
                    smsViewController.title = "Enter Code"
                    self?.navigationController?.pushViewController(smsViewController, animated: true)
                }
            }
        }
        return true
    }
}

