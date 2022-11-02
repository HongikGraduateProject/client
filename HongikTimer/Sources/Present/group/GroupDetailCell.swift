//
//  GroupDetailCell.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/02.
//

import UIKit

final class GroupDetailCell: UICollectionViewCell {
  
  lazy var memberImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFit
    
  }
  
  private lazy var memberNameLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14.0, weight: .regular)
    $0.textColor = .label
    $0.numberOfLines = 1
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Method

private extension GroupDetailCell {
  
  func configureUI() {
    
    backgroundColor = .systemBackground
    
    [
      memberImageView,
      memberNameLabel
    ].forEach { addSubview($0) }
  
    memberImageView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(16.0)
      $0.centerX.equalToSuperview()
    }
    
    memberNameLabel.snp.makeConstraints {
      $0.top.equalTo(memberImageView.snp.bottom).offset(16.0)
      $0.centerX.equalToSuperview()
    }
  }
}
