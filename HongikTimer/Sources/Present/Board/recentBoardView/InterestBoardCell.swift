//
//  InterestBoardCell.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Foundation

import SnapKit
import Then
import UIKit

final class InterestBoardCell: UICollectionViewCell {
    
    private lazy var writerImageView = UIImageView().then {
        $0.layer.cornerRadius = 15
        $0.tintColor = .label
        $0.contentMode = .scaleToFill
    }
    
    private lazy var nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0)
        $0.textColor = .label
        $0.numberOfLines = 1
    }

    private lazy var timeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0, weight: .light)
        $0.textColor = .systemGray
        $0.numberOfLines = 1
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .bold)
        $0.textColor = .label
        $0.numberOfLines = 1
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0, weight: .regular)
        $0.textColor = .systemGray
        $0.numberOfLines = 2
    }

    private lazy var contentImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .label.withAlphaComponent(0.3)
    }
    
    private lazy var upImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(systemName: "hand.thumbsup")
        $0.tintColor = .label
    }
    
    private lazy var upCountLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0)
        $0.textColor = .label
        $0.numberOfLines = 1
    }
    
    private lazy var bubbleImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.image = UIImage(systemName: "bubble.right")
        $0.tintColor = .label
    }
    
    private lazy var bubbleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16.0)
        $0.textColor = .label
        $0.numberOfLines = 1
    }
    
    private lazy var separatorView = UIView().then {
        $0.backgroundColor = .separator
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
        writerImageView.image = UIImage(systemName: "person.circle")
        nameLabel.text = "김홍익"
        timeLabel.text = "15 시간 전"
        titleLabel.text = "타이틀 라벨입니다. 타이틀 라벨입니다. 타이틀 라벨입니다. 타이틀 라벨입니다."
        contentLabel.text = "콘텐트 라벨입니다. 콘텐트 라벨입니다.콘텐트 라벨입니다.콘텐트 라벨입니다.콘텐트 라벨입니다.콘텐트 라벨입니다.콘텐트 라벨입니다."
        contentImageView.image = UIImage(systemName: "photo")
        upCountLabel.text = String(11)
        bubbleLabel.text = String(33)
    }
}

// MARK: - Private

private extension InterestBoardCell {
    func setupLayout() {
        backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemBackground
        contentView.layer.masksToBounds = false

        let countStackView = UIStackView(arrangedSubviews: [
            upImageView,
            upCountLabel,
            bubbleImageView,
            bubbleLabel
        ]).then {
            $0.axis = .horizontal
            $0.distribution = .fillProportionally
            $0.alignment = .leading
            $0.spacing = 8
        }
                
        [
            writerImageView,
            nameLabel,
            timeLabel,
            titleLabel,
            contentLabel,
            contentImageView,
            countStackView,
            separatorView
        ].forEach { addSubview($0) }
        
        writerImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(24.0)
            $0.leading.equalToSuperview().inset(16.0)
            $0.height.width.equalTo(30.0)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(writerImageView)
            $0.leading.equalTo(writerImageView.snp.trailing).offset(4.0)
        }
        
        timeLabel.snp.makeConstraints {
            $0.bottom.equalTo(writerImageView)
            $0.leading.equalTo(nameLabel)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(nameLabel)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        contentImageView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(16.0)
            $0.leading.trailing.equalTo(contentLabel)
            $0.height.equalTo(200.0)
        }
        
        countStackView.snp.makeConstraints {
            $0.top.equalTo(contentImageView.snp.bottom).offset(16.0)
            $0.leading.equalTo(nameLabel)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(countStackView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(1.0)
        }
    }
}

// TODO: 관심분야 추가
