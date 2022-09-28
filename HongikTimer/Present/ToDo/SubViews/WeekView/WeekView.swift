//
//  WeekView.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/28.
//

import SnapKit
import Then
import UIKit

final class WeekView: UIView {
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        
        $0.collectionViewLayout = layout 
        $0.backgroundColor = .red
        $0.delegate = self
        $0.dataSource = self
        $0.register(
            UICollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "header"
        )
        $0.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "cell"
        )
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionView

extension WeekView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        5
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        )
        return cell
    }
}

extension WeekView: UICollectionViewDelegate {
    
}

// MARK: - Private

private extension WeekView {
    func setupLayout() {
        [
            collectionView
        ].forEach { addSubview($0) }
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
