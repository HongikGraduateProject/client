//
//  InterestBoardView.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import SnapKit
import Then
import UIKit

final class InterestBoardView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "새로 올라온 관심글💘"
        $0.font = .systemFont(
            ofSize: 24.0,
            weight: .bold
        )
        $0.textColor = .label
    }
    
    private lazy var interestLabel = UILabel()
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    ).then {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(
            top: 4.0,
            left: 4.0,
            bottom: 24.0,
            right: 4.0
        )
        
        $0.collectionViewLayout = layout
        $0.showsHorizontalScrollIndicator = false
        
        $0.dataSource = self
        $0.delegate = self
        
        $0.backgroundColor = .systemBackground
        
        $0.register(
            InterestBoardCell.self,
            forCellWithReuseIdentifier: InterestBoardCell.idenifier
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

extension InterestBoardView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        10
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: InterestBoardCell.idenifier,
            for: indexPath
        ) as? InterestBoardCell else { return UICollectionViewCell() }
        
        cell.setupCell()
                    
        return cell
    }
}

extension InterestBoardView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: layer.frame.width, height: 400)
    }
}

// MARK: - Private

private extension InterestBoardView {
    func setupLayout() {
        backgroundColor = .systemBackground
        
        [
            titleLabel,
            collectionView
        ].forEach { addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8.0)
            $0.leading.trailing.equalToSuperview().inset(4.0)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4.0)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// TODO: cell 자동높이 조절 공부
