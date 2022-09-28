//
//  TaskCell.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/27.
//

import SnapKit
import Then
import UIKit

final class TaskCell: UICollectionViewCell {

    private lazy var checkButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square"), for: .normal)
        $0.tintColor = .label
    }
    
    private lazy var textField = UITextField().then {
        $0.placeholder = "입력"
    }
    
    private lazy var setButton = UIButton().then {
        $0.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        $0.tintColor = .systemGray2
    }

    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private

private extension TaskCell {
    
    func setupLayout() {
            
        [
            checkButton,
            textField,
            setButton
        ].forEach { addSubview($0) }
        
        checkButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.height.width.equalTo(32.0)
            $0.centerY.equalToSuperview()
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(checkButton.snp.trailing).offset(8.0)
            $0.height.equalTo(16.0)
            $0.trailing.equalTo(setButton.snp.leading).offset(16.0)
            $0.centerY.equalTo(checkButton)
        }
        
        setButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.height.width.equalTo(16.0)
        }
    }
}
