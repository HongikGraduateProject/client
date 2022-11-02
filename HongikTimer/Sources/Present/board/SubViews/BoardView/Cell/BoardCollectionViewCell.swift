//
//  PostCollectionViewCell.swift
//  10-2-home
//
//  Created by JongHoon on 2022/10/15.
//

import Then
import SnapKit
import UIKit

final class BoardCollectionViewCell: UICollectionViewCell {
    
    private lazy var postImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.layer.cornerRadius = 8.0
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .bold)
        $0.textColor = .label
        $0.numberOfLines = 1
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14.0, weight: .regular)
        $0.textColor = UIColor(rgb: 0x6C6464)
        $0.numberOfLines = 1
    }
    
    private lazy var memberLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12.0, weight: .regular)
        $0.textColor = UIColor(rgb: 0xC7C7C7)
        $0.numberOfLines = 1
    }
    
    private lazy var stateButton = UIButton().then {
        $0.isEnabled = false
        $0.setTitle("마감임박", for: .normal)
        $0.setTitleColor(
            UIColor(rgb: 0x204EC5),
            for: .normal
        )
        $0.backgroundColor = UIColor(rgb: 0xF0F5FF)
        $0.titleLabel?.font = .systemFont(
            ofSize: 10.0,
            weight: .regular
        )
        $0.layer.cornerRadius = 4.0
    }
    
    private lazy var separatorView = UIView().then {
        $0.backgroundColor = .separator.withAlphaComponent(0.3)
    }
    
    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLayout()
        postImageView.image = UIImage(named: "post")
        titleLabel.text = "빡코더 모집!"
        contentLabel.text = "24시간 빡코딩할 분들 모집합니다!!"
        memberLabel.text = "빡코더 | 멤버 249 / 250"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension BoardCollectionViewCell {
    
    func configureLayout() {
                
        let labelStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            contentLabel,
        ]).then {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 8.0
        }
        
        [
            postImageView,
            labelStackView,
            memberLabel,
            stateButton,
            separatorView
        ].forEach { addSubview($0) }
        
        postImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16.0)
            $0.width.height.equalTo(80.0)
        }
        
        labelStackView.snp.makeConstraints {
            $0.top.equalTo(postImageView)
            $0.leading.equalTo(postImageView.snp.trailing ).offset(20.0)
            $0.trailing.equalToSuperview().inset(16.0)
        }
        
        memberLabel.snp.makeConstraints {
            $0.top.equalTo(labelStackView.snp.bottom).offset(8.0)
            $0.leading.equalTo(labelStackView)
        }
        
        stateButton.snp.makeConstraints {
            $0.centerY.equalTo(memberLabel)
            $0.leading.equalTo(memberLabel.snp.trailing).offset(8.0)
            $0.width.equalTo(54.0)
            $0.height.equalTo(16.0)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(postImageView.snp.bottom).offset(8.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
            $0.height.equalTo(0.3)
        }
    }
}
