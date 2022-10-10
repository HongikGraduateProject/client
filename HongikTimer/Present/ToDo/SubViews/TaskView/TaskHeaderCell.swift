//
//  TaskHeaderCell.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/27.
//

import SnapKit
import Then
import UIKit

final class TaskHeaderCell: UICollectionReusableView {
    
    var tapAddTodoCompletion: ((TaskCell) -> Void)?
    
    private lazy var headerView = HeaderView().then {
        $0.layer.cornerRadius = 12.0
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAddTodoHeader)
        )
        $0.addGestureRecognizer(tap)
        $0.isUserInteractionEnabled = true
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

private extension TaskHeaderCell {
    
    func setupLayout() {
        [
            headerView
        ].forEach { addSubview($0) }
        
        headerView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.top.bottom.equalToSuperview()
            $0.height.equalTo(20.0)
        }
    }
    
    // MARK: - Selector
    
    @objc func tapAddTodoHeader() {
        let vm = TaskViewModel(task: Task)
        tapAddTodoCompletion?(TaskViewModel)
    }
}
