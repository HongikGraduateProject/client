//
//  EmailSignUpViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import Firebase
import SnapKit
import Then
import UIKit
import CloudKit
import ReactorKit
import RxSwift
import RxCocoa

final class EmailSignUpViewController: BaseViewController {
  
  //    var userVM: UserViewModel?

  // MARK: - Property
  
  let reactor: EmailSignUpReactor!
  
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
  
  private lazy var signinButton = UIButton(configuration: labelConfig).then {
    $0.setTitle("회원가입", for: .normal)
    $0.setTitleColor(.systemBackground, for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .bold)
    $0.addTarget(
      self,
      action: #selector(tapsigninButton),
      for: .touchUpInside
    )
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    setupNavigationBar()
    setupLayout()
    bind(reactor: self.reactor)
  }
  
  // MARK: - Init
  
  init(with reactor: EmailSignUpReactor) {
    self.reactor = reactor
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - bind

extension EmailSignUpViewController: View {
  func bind(reactor: EmailSignUpReactor) {
    
    // MARK: Action
    emailTextField.textField.rx.text
      .orEmpty
      .map { Reactor.Action.emailInput($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    nicknameTextField.textField.rx.text
      .orEmpty
      .map { Reactor.Action.nicknameInput($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    
    passwordTextField.textField.rx.text
      .orEmpty
      .map { Reactor.Action.passwordInput($0) }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    let passwordText = passwordTextField.textField.rx.text.orEmpty.map { $0 }
    let passwordCheckText = passwordCheckTextField.textField.rx.text.orEmpty.map { $0 }
    
    Observable.combineLatest(
      passwordText,
      passwordCheckText
    )
    .map { Reactor.Action.passwordCheckInput($0, $1) }
    .bind(to: reactor.action)
    .disposed(by: disposeBag)
       
    // MARK: State
    reactor.state.asObservable().map { $0.emailMessage }
      .bind(to: emailTextField.messageLabel.rx.attributedText)
      .disposed(by: disposeBag)
    
    reactor.state.asObservable().map { $0.nickNameMessage }
      .bind(to: nicknameTextField.messageLabel.rx.attributedText)
      .disposed(by: disposeBag)
    
    reactor.state.asObservable().map { $0.passwordMessage }
      .bind(to: passwordTextField.messageLabel.rx.attributedText)
      .disposed(by: disposeBag)
    
    reactor.state.asObservable().map { $0.passwordCheckMessage }
      .bind(to: passwordCheckTextField.messageLabel.rx.attributedText)
      .disposed(by: disposeBag)
  }
}

// MARK: - TextField

extension EmailSignUpViewController: UITextFieldDelegate {
  func textFieldShouldReturn(
    _ textField: UITextField
  ) -> Bool {
    if textField == emailTextField.textField {
      nicknameTextField.textField.becomeFirstResponder()
    } else if textField == nicknameTextField.textField {
      passwordTextField.textField.becomeFirstResponder()
    } else if textField == passwordTextField.textField {
      passwordCheckTextField.textField.becomeFirstResponder()
    } else if textField == passwordCheckTextField.textField {
      tapsigninButton()
    }
    return true
  }
}

// MARK: - Private

private extension EmailSignUpViewController {
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
      signinButton
    ]).then {
      $0.axis = .vertical
      $0.distribution = .equalSpacing
      $0.spacing = 48.0
      
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
      $0.top.equalToSuperview().inset(100.0)
      $0.leading.trailing.equalToSuperview().inset(authDefaultInset)
    }
  }
  
  // MARK: - Selector
  
  @objc func tapsigninButton() {
    emailTextField.textField.resignFirstResponder()
    nicknameTextField.textField.resignFirstResponder()
    passwordTextField.textField.resignFirstResponder()
    passwordCheckTextField.textField.resignFirstResponder()
    
    guard let email = emailTextField.textField.text, !email.isEmpty else { return }
    guard let username = nicknameTextField.textField.text, !username.isEmpty else { return }
    guard let password = passwordTextField.textField.text, !password.isEmpty else { return }
    guard let passwordCheck = passwordCheckTextField.textField.text, !passwordCheck.isEmpty else { return }
    
    if password != passwordCheck {
      view.makeToast("비밀번호와 비밀번호 확인이 일치하지 않습니다", position: .top)
    }
    
    let authCredentials = AuthCredentials(
      email: email,
      username: username,
      password: password
    )
    
    AuthService.shared.signInWithEmail(
      credentials: authCredentials
    ) { [weak self] result, error in
      if let error = error {
        print("DEBUG 이메일 회원가입 에러 \(error)")
        return
      }
      
      guard let uid = result?.user.uid else { return }
      
      let values = [
        "email": email,
        "username": username
      ]
      
      refUSERS.child(uid).updateChildValues(values) { error, ref in
        if let error = error {
          print(error)
        }
        
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self?.present(vc, animated: true)
      }
    }
  }
}

// TODO: 회원가입 에러 처리
