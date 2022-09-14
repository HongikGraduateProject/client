//
//  TextFieldView.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import SnapKit
import Then
import UIKit

final class TextFieldView: UIView {
    
    let placeHolder: String?
    
    lazy var textField = UITextField().then {
        $0.placeholder = placeHolder
        $0.tintColor = .defaultTintColor
        $0.returnKeyType = .next
    }
    
    private lazy var seperatorView = UIView().then {
        $0.backgroundColor = .separator
    }
    
    // MARK: - Lifecycle
    
    init(with placeHolder: String) {
        self.placeHolder = placeHolder
        
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getText(completion: (String) -> Void) {
        guard let text = textField.text else { return }
        completion(text)
    }
}

private extension TextFieldView {
    func setupLayout() {
        [
            textField,
            seperatorView
        ].forEach { addSubview($0) }
        
        textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
        }
        
        seperatorView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(4.0)
            $0.leading.trailing.equalTo(textField)
            $0.height.equalTo(0.5)
        }
    }
}
