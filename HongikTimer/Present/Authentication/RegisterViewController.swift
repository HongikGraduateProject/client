//
//  RegisterViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import SnapKit
import Then
import UIKit

final class RegisterViewController: UIViewController {
    
    private var labelConfig = ButtonConfig(buttonConfig: .label).getConfig()
    
    private lazy var logoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "timer")
    }
    
    private lazy var registerButton = UIButton(configuration: labelConfig).then {
        $0.setTitle("계정 만들기", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.addTarget(
            self,
            action: #selector(tapRegisterButton),
            for: .touchUpInside
        )
    }
    
    private lazy var moveToLoginLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.textColor = .secondaryLabel
        $0.text = "이미 계정이 있으세요?"
    }
    
    private lazy var moveToLoginButton = UIButton().then {
        $0.setTitle("로그인하기", for: .normal)
        $0.setTitleColor(.link, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .medium)
        $0.addTarget(
            self,
            action: #selector(tapLoginButton),
            for: .touchUpInside
        )
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
}

// MARK: - Private

private extension RegisterViewController {
    func setupLayout() {
        
        let stackView = UIStackView(
            arrangedSubviews: [moveToLoginLabel, moveToLoginButton]
        ).then {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.spacing = 4.0
        }
        
        [
            logoImageView,
            registerButton,
            stackView
        ].forEach { view.addSubview($0) }
        
        logoImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100.0)
            $0.height.width.equalTo(150.0)
        }
        
        registerButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(52.0)
            $0.bottom.equalToSuperview().inset(200.0)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.bottom.equalToSuperview().inset(36.0)
            $0.height.equalTo(16.0)
        }
    }
    
    // MARK: - Selector
    
    @objc func tapRegisterButton() {
        let vc = EmailRegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func tapLoginButton() {
        let vc = UINavigationController(
            rootViewController: LoginViewController()
        )
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
