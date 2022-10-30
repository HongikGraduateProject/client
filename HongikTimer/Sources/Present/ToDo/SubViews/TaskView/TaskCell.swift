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
    private var indexPath: IndexPath?
    private var isEditMode: Bool = false
    
    var tapEditButtonCompletion: ((String) -> Void)?
        
    /// 텍스트필드 입력값이 empty가 아니면 입력값으로 viewModelList update
    var textFieldNotEmptyCompletion: ((TaskViewModel) -> Void)?
    
    /// 텍스트필드 입력값이 empty이면 viewModelList의 마지막 요소 삭제
    var textFieldEmptyCompletion: (() -> Void)?
    
    /// Task 수정 completion
    var textFieldEditCompletion: ((TaskViewModel, IndexPath) -> Void)?
    
    private let squareImage = UIImage(systemName: "square")
    private let checkSquareImage = UIImage(systemName: "checkmark.square")

    private lazy var checkButton = UIButton().then {
        $0.setImage(squareImage, for: .normal)
        $0.tintColor = .label
        $0.addTarget(
            self,
            action: #selector(toggleCheck),
            for: .touchUpInside
        )
    }
    
    lazy var textField = UITextField().then {
        $0.placeholder = "입력"
        $0.delegate = self
    }
    
    private lazy var editButton = UIButton().then {
        $0.setImage(
            UIImage(systemName: "ellipsis"),
            for: .normal
        )
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
        textField.isEnabled = false
        
        let image = vm.isChecked ? checkSquareImage : squareImage
        checkButton.setImage(image, for: .normal)
    }
    
    func textFieldEditMode(_ indexPath: IndexPath) {
        self.indexPath = indexPath
        textField.isEnabled = true
        isEditMode = true
        textField.becomeFirstResponder()
    }
}

// MARK: - TextField

extension TaskCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if isEditMode == false {
            taskVM = TaskViewModel(task: Task(
                taskId: 0,
                userId: 0,
                contents: textField.text ?? "",
                isChecked: false)
            )
            textField.isEnabled = false
            if textField.text?.isEmpty == false {
                guard let taskVM = taskVM else { return false }
                textFieldNotEmptyCompletion?(taskVM)
            } else {
                textFieldEmptyCompletion?()
            }
        } else {
            guard let task = taskVM?.task else { return false }
            taskVM = TaskViewModel(task: Task(
                taskId: task.taskId,
                userId: task.userId,
                contents: textField.text ?? "",
                isChecked: task.isChecked ?? false)
            )
            guard let taskVM = taskVM else { return false }
            textField.isEnabled = false
            isEditMode = false
            textFieldEditCompletion?(taskVM, indexPath ?? [])
        }
        
        return true
    }
}

// MARK: - Private

private extension TaskCell {
    
    func setupLayout() {
            
        [
            checkButton,
            textField,
            editButton
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
            $0.trailing.equalTo(editButton.snp.leading).offset(16.0)
            $0.centerY.equalTo(checkButton)
        }
        
        editButton.snp.makeConstraints {
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
    
    // TODO: button 클릭시 viewModelList 업데이트, 마지막 todo 클릭시 한번만 바뀜
}
