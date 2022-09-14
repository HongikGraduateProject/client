//
//  SetPurposeViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import SnapKit
import Then
import UIKit
import SwiftUI

protocol SavePurposeDelegate: AnyObject {
    func savePurpose(with purpose: String)
}

final class SetPurposeViewController: UIViewController {
    
    weak var delegate: SavePurposeDelegate?
    
    private let barButtonTintColor = UIColor.white
    
    private lazy var textField = UITextField().then {
        $0.textColor = .white
        $0.tintColor = .defaultTintColor
        $0.font = .systemFont(ofSize: 16.0, weight: .medium)
        $0.textAlignment = .center
        $0.becomeFirstResponder()
        $0.delegate = self
        $0.addAction(UIAction(handler: textHandler), for: .editingChanged)
    }
    
    private lazy var countLabel = UILabel().then {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 12.0, weight: .light)
        $0.text = "0 / 20"
    }
    
    private lazy var leftBarButton = UIBarButtonItem(
        title: "취소",
        style: .plain,
        target: self,
        action: #selector(tapLeftBarButton)
    ).then {
        $0.tintColor = barButtonTintColor
    }
    
    private lazy var rightBarButton = UIBarButtonItem(
        title: "확인",
        style: .plain,
        target: self,
        action: #selector(tapRightBarButton)
    ).then {
        $0.tintColor = barButtonTintColor
        $0.isEnabled = false
    }
        
    private lazy var seperatorView = UIView().then {
        $0.backgroundColor = .separator
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black.withAlphaComponent(0.9)
        setNavigationBar()
        setupLayout()
    }
    
    init(delegate: SavePurposeDelegate) {
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - TextField

extension SetPurposeViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false}
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: string)
        countLabel.text = "\(changedText.count) / 20"
        
        return changedText.count <= 19
    }
}

// MARK: - Private

private extension SetPurposeViewController {
    
    func setNavigationBar() {

        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    func setupLayout() {
        [
            textField,
            seperatorView,
            countLabel
        ].forEach { view.addSubview($0) }
        
        textField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.keyboardLayoutGuide).offset(-218)
        }
        
        seperatorView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.top.equalTo(textField.snp.bottom)
        }
        
        countLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(seperatorView.snp.bottom).offset(4.0)
        }
    }
    
    func textHandler(_: UIAction) {
        if self.textField.text?.isEmpty == true {
            self.rightBarButton.isEnabled = false
        } else {
            self.rightBarButton.isEnabled = true
        }
    }
    
    // MARK: - Selector
    
    @objc func tapLeftBarButton() {
        dismiss(animated: true)
    }
    
    @objc func tapRightBarButton() {
        guard let purpose = textField.text else { return }
        delegate?.savePurpose(with: purpose)
        dismiss(animated: true)
    }
}
