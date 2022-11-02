//
//  BoardView.swift
//  10-2-home
//
//  Created by JongHoon on 2022/10/15.
//

import Then
import SnapKit
import UIKit

final class BoardView: UIView {
    
    private lazy var refreshControl = UIRefreshControl().then {
        $0.attributedTitle = NSAttributedString(
            string: "당겨서 새로 고침! 🔥👨‍💻",
            attributes: [.foregroundColor: UIColor.label]
        )
        $0.addTarget(
            self,
            action: #selector(refresh),
            for: .valueChanged
        )
    }
    
    private lazy var boardCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(
            top: 16.0,
            left: 0,
            bottom: 16.0,
            right: 0
        )
        
        $0.collectionViewLayout = layout
        $0.showsVerticalScrollIndicator = false
        
        $0.refreshControl = refreshControl
        
        $0.dataSource = self
        $0.delegate = self
        
        $0.register(
            BoardCollectionViewCell.self,
            forCellWithReuseIdentifier: BoardCollectionViewCell.identifier
        )
        $0.register(
            BoardCollectionReusableView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: BoardCollectionReusableView.idenifier
        )
    }
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - CollectionView

extension BoardView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        20
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BoardCollectionViewCell.identifier,
            for: indexPath
        ) as? BoardCollectionViewCell
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        viewForSupplementaryElementOfKind kind: String,
        at indexPath: IndexPath
    ) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: BoardCollectionReusableView.idenifier,
            for: indexPath
        ) as? BoardCollectionReusableView
        
        return header ?? UICollectionReusableView()
    }
}

extension BoardView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: frame.width, height: 100.0)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        return CGSize(width: frame.width, height: 170.0)
    }
}


// MARK: - Private

private extension BoardView {
    
    func configureLayout() {
        [
            boardCollectionView
        ].forEach { addSubview($0) }
    
        boardCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // MARK: - Selector

    @objc func refresh() {
        refreshControl.endRefreshing()
    }
}
