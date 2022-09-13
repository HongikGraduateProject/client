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
    
    private lazy var textField = UITextField().then {
        $0.placeholder = "목표를 입력하세요!"
        $0.tintColor = .white
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
// TODO: 화면 전환시 바로 커서 텍스트 필드로 오게, 글자수 표시
    
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

// MARK: - Private

private extension SetPurposeViewController {
    
    func setNavigationBar() {
        let barButtonTintColor = UIColor.systemGray4
        
        let leftButton = UIBarButtonItem(
            title: "취소",
            style: .plain,
            target: self,
            action: #selector(tapLeftBarButton)
        ).then {
            $0.tintColor = barButtonTintColor
        }
        
        let rightButton = UIBarButtonItem(
            title: "확인",
            style: .plain,
            target: self,
            action: #selector(tapRightBarButton)
        ).then {
            $0.tintColor = barButtonTintColor
        }

        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
    }
    
    func setupLayout() {
        [
            textField,
            seperatorView
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
