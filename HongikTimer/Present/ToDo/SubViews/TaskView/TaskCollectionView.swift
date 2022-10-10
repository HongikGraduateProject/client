//
//  TaskCollectionView.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/28.
//

import SnapKit
import Then
import UIKit

final class TaskCollectionView: UIView {
    
    private var taskListVM = TaskListViewModel()
        
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        
        $0.alwaysBounceVertical = true
        $0.collectionViewLayout = layout
        $0.backgroundColor = .systemBackground
        $0.delegate = self
        $0.dataSource = self
        $0.register(
            TaskHeaderCell.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: TaskHeaderCell.idenifier
        )
        $0.register(
            TaskCell.self,
            forCellWithReuseIdentifier: TaskCell.idenifier
        )
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

// MARK: - CollectionView

extension TaskCollectionView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        taskListVM.numberOfRows(section)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TaskCell.identifier,
            for: indexPath
        ) as? TaskCell
        let taskVM = taskListVM.modelAt(indexPath.row)
        
        if taskVM.contents.isEmpty == false {
            cell?.setupCell(taskVM)
        } else {
            cell?.textField.becomeFirstResponder()
        }
        
        cell?.textFieldNotEmptyCompletion = { [weak self] taskVM in
            self?.taskListVM.updateTaskViewModel(taskVM)
            self?.taskListVM.addTaskViewModel(TaskViewModel(task: Task()))
            
            collectionView.reloadData()
        }
        
        cell?.textFieldEmptyCompletion = { [weak self] in
            self?.taskListVM.removeEndIndex()
            collectionView.reloadData()
            
        }
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TaskHeaderCell.idenifier,
            for: indexPath
        ) as? TaskHeaderCell
        
        headerView?.tapAddTodoCompletion = { [weak self] taskVM in
            self?.taskListVM.addTaskViewModel(taskVM)
            
            collectionView.reloadData()
        }
        
        return headerView ?? UICollectionReusableView()
    }
}

extension TaskCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: self.frame.width, height: 48.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: 100.0, height: 48.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    
}

// MARK: - Private

private extension TaskCollectionView {
    func setupLayout() {
        [
            collectionView
        ].forEach { addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // TODO: 키보드가 todo작성 textField 가리는거 해결
    }
}
