//
//  EmailRegisterViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import Firebase
import SnapKit
import Then
import UIKit

final class EmailRegisterViewController: UIViewController {
        
    private lazy var emailTextField = TextFieldView(with: "이메일").then {
        $0.textField.becomeFirstResponder()
        $0.textField.delegate = self
    }
    
    private lazy var nicknameTextField = TextFieldView(with: "별명").then {
        $0.textField.delegate = self
    }
    private lazy var passwordTextField = TextFieldView(with: "비밀번호").then {
        $0.textField.delegate = self
    }
    
    private lazy var passwordCheckTextField = TextFieldView(with: "비밀번호 확인").then {
        $0.textField.delegate = self
        $0.textField.returnKeyType = .done
    }
    
    private lazy var registerButton = UIButton(configuration: labelConfig).then {
        $0.setTitle("회원가입", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.addTarget(
            self,
            action: #selector(tapRegisterButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupLayout()
    }
}

// MARK: - TextField

extension EmailRegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        if emailTextField.textField.isFirstResponder {
            nicknameTextField.textField.becomeFirstResponder()
        } else if nicknameTextField.textField.isFirstResponder {
            passwordTextField.textField.becomeFirstResponder()
        } else if passwordTextField.textField.isFirstResponder {
            passwordCheckTextField.textField.becomeFirstResponder()
        }
        return true
    }
}

// MARK: - Private

private extension EmailRegisterViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        
        let stackView = UIStackView(arrangedSubviews: [
            emailTextField,
            nicknameTextField,
            passwordTextField,
            passwordCheckTextField,
            registerButton
        ]).then {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 42.0
            
            [
                emailTextField,
                nicknameTextField,
                passwordTextField,
                passwordCheckTextField
            ].forEach { $0.snp.makeConstraints {
                $0.height.equalTo(textFieldHeight)
            }}
        }
        
        [
            stackView
        ].forEach { view.addSubview($0) }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(150.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }
    }
    
    // MARK: - Selector
    
    @objc func tapRegisterButton() {
        
    }
}
