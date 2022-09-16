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
        $0.textField.isSecureTextEntry = true
    }
    
    private lazy var passwordCheckTextField = TextFieldView(with: "비밀번호 확인").then {
        $0.textField.delegate = self
        $0.textField.returnKeyType = .done
        $0.textField.isSecureTextEntry = true
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
        navigationItem.title = "회원가입"
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
            $0.leading.trailing.equalToSuperview().inset(authDefaultInset)
        }
    }
    
    // MARK: - Selector
    
    @objc func tapRegisterButton() {
        guard let email = emailTextField.textField.text else { return }
        guard let nickname = nicknameTextField.textField.text else { return }
        guard let password = passwordTextField.textField.text else { return }
        guard let passwordCheck = passwordCheckTextField.textField.text else { return }
        
        if password != passwordCheck {
            view.makeToast("비밀번호와 비밀번호 확인이 일치하지 않습니다", position: .top)
        }
        
        let authCredentials = AuthCredentials(
            email: email,
            nickname: nickname,
            password: password
        )
        EmailAuthService.shared.registerUser(
            credentials: authCredentials
        ) { result, error in
            if let error = error {
                print("DEBUG Error is \(error)")
                return
            }
            
            guard let uid = result?.user.uid else { return }
            
            let values = [
                "email": email,
                "nickname": nickname
            ]
            
            refUSERS.child(uid).updateChildValues(values) { error, ref in
                if let error = error {
                    print(error)
                }
                
                let window = (
                    UIApplication
                    .shared
                    .connectedScenes
                    .first as? UIWindowScene
                )?.keyWindow
                
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
    }
}
