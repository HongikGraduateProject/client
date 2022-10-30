//
//  PopularBoardCell.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import SnapKit
import Then
import UIKit

final class PopularBoardCell: UICollectionViewCell {
    
    private lazy var sortLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0, weight: .bold)
        $0.textColor = .systemGray
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.textColor = .label
        $0.numberOfLines = 0
    }
    
    private lazy var imageView = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.tintColor = .label
        $0.contentMode = .scaleToFill
    }

    private lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0)
        $0.textColor = .label
    }
    
// MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Public
    
    func setupCell() {
        sortLabel.text = "조회수 TOP5"
        titleLabel.text = "파이썬, 자바, 스위프트 공부법 2주만에 완성하는 공부법!!!"
        imageView.image = UIImage(systemName: "person.circle")
        nameLabel.text = "개발왕"
        
            }
}

// MARK: - Private

private extension PopularBoardCell {
    func setupLayout() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        contentView.layer.masksToBounds = false

        [
            sortLabel,
            titleLabel,
            imageView,
            nameLabel
        ].forEach { addSubview($0) }
        
        sortLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(sortLabel.snp.bottom).offset(8.0)
            $0.leading.trailing.equalTo(sortLabel)
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16.0)
            $0.leading.equalTo(sortLabel)
            $0.height.width.equalTo(30.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(4.0)
        }
    }
}
