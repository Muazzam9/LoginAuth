//
//  SMSCodeViewController.swift
//  bookit
//
//  Created by Muazzam.Aziz on 2022/09/28.
//

import UIKit

class SMSCodeViewController: UIViewController, UITextFieldDelegate {
    
    private let codeField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Code"
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
        view.addSubview(codeField)
        codeField.frame = CGRect(x: 0, y: 0, width: 220, height: 50)
        codeField.center = view.center
        codeField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            let code = text
            AuthenticationManager.shared.verifyCode(smsCode: code) { [weak self] success in
                guard success else { return }
                DispatchQueue.main.async {
                    let accountViewController = AccountViewController()
                    accountViewController.modalPresentationStyle = .fullScreen
                    self?.present(accountViewController, animated: true)
                }
            }
        }
        return true
    }
}

