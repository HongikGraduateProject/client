//
//  LoginViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import SnapKit
import Then
import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Lifecycle
    
    private var labelConfig = ButtonConfig(buttonConfig: .label).getConfig()
    
    private lazy var emailTextField = TextFieldView(with: "이메일").then {
        $0.textField.becomeFirstResponder()
        $0.textField.delegate = self
    }
    
    private lazy var passwordTextField = TextFieldView(with: "비밀번호").then {
        $0.textField.returnKeyType = .done
//        $0.textField.delegate = self
    }
    
    private lazy var loginButton = UIButton(configuration: labelConfig).then {
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupLayout()
    }
}

// MARK: - TextField

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField.textField {
            passwordTextField.textField.becomeFirstResponder()
        }
        
        return true
    }
}

// MARK: - Private

private extension LoginViewController {
    
    func setupNavigationBar() {
        
        lazy var leftBarButton = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(tapLeftBarButton)
        )
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func setupLayout() {
        
        view.backgroundColor = .systemBackground
        [
            emailTextField,
            passwordTextField,
            loginButton
        ].forEach { view.addSubview($0) }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalToSuperview().inset(200.0)
            $0.leading.trailing.equalToSuperview().offset(24.0)
            $0.height.equalTo(textFieldHeight)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom).offset(48.0)
            $0.leading.trailing.equalTo(emailTextField)
            $0.height.equalTo(textFieldHeight)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordTextField.snp.bottom).offset(48.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }
    }
    
    // MARK: - Selector
    
    @objc func tapLeftBarButton() {
        dismiss(animated: true)
    }
}
