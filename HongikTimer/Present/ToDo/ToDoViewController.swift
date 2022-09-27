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
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        
        $0.backgroundColor = .systemBackground
        $0.delegate = self
        $0.dataSource = self
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: - CollectionView

extension ToDoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

extension ToDoViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Private

private extension ToDoViewController {
    func setupLayout() {
        
    }
}
