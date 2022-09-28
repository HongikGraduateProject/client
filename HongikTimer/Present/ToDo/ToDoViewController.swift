//
//  ToDoViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/27.
//

import SnapKit
import Then
import UIKit

final class ToDoViewController: UIViewController {
    
    private var tasks = [Task]()
    
    private lazy var weekView = WeekView()
    private lazy var taskView = TaskView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
}

// MARK: - Private

private extension ToDoViewController {
    func setupLayout() {
        [
            weekView,
            taskView
        ].forEach { view.addSubview($0) }
        
        weekView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(64.0)
        }
        
        taskView.snp.makeConstraints {
            $0.top.equalTo(weekView.snp.bottom).offset(16.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
