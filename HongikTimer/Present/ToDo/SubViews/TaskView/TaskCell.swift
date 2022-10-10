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

    private var taskVM: TaskViewModel?

    private let squareImage = UIImage(systemName: "square")
    private let checkSquareImage = UIImage(systemName: "checkmark.square")

    private lazy var checkButton = UIButton().then {
        $0.setImage(squareImage, for: .normal)
        $0.tintColor = .label
        $0.addTarget(self, action: #selector(toggleCheck), for: .touchUpInside)
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
    
    func setupCell(_ vm: TaskViewModel) {
        taskVM = vm
        textField.text = vm.contents
        let image = vm.isChecked ? checkSquareImage : squareImage
        checkButton.setImage(image, for: .normal)
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

// MARK: - selector
    
    @objc func toggleCheck() {
        if taskVM?.isChecked == true {
            taskVM?.isChecked = false
            checkButton.setImage(
                squareImage,
                for: .normal
            )
        } else {
            taskVM?.isChecked = true
            checkButton.setImage(
                checkSquareImage,
                for: .normal
            )
        }
    }
}
