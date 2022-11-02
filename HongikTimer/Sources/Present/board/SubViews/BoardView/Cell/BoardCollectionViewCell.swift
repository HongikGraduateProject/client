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
  
  
  private lazy var categoryLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14.0, weight: .medium)
    $0.textColor = .defaultTintColor
  }
  
  private lazy var titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 16.0, weight: .bold)
    $0.textColor = .label
    $0.numberOfLines = 1
  }
  
  private lazy var purposeLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private lazy var memberLabel = UILabel().then {
    $0.numberOfLines = 1
  }

  lazy var chiefLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  lazy var startDayLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  lazy var totalTimeLabel = UILabel().then {
    $0.numberOfLines = 1
  }
  
  private lazy var contentLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 14.0, weight: .regular)
    $0.textColor = .label
    $0.numberOfLines = 2
  }
  
  
  private lazy var separatorView = UIView().then {
    $0.backgroundColor = .quaternaryLabel
  }
  
  // MARK: - Lifecycle
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    configureLayout()
    categoryLabel.text = "대학생"
    titleLabel.text = "파이썬 코테 스터디"
    purposeLabel.attributedText = makeLabel("목표", content: "5시간")
    memberLabel.attributedText = makeLabel("인원", content: "1/3명")
    chiefLabel.attributedText = makeLabel("그룹장", content: "영미")
    startDayLabel.attributedText = makeLabel("시작일", content: "22. 4. 11")
    totalTimeLabel.attributedText = makeLabel("공부량", content: "5시간 23분")
    
    contentLabel.text = "파이썬 코딩테스트 모집합니다~~"
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private

private extension BoardCollectionViewCell {
  
  func configureLayout() {
    
    let firstLineStackView = UIStackView(arrangedSubviews: [
      purposeLabel,
      memberLabel,
      chiefLabel
    ]).then {
      $0.axis = .horizontal
      $0.distribution = .equalSpacing
      $0.spacing = 8.0
    }
    
    let secondLineStackView = UIStackView(arrangedSubviews: [
      startDayLabel,
      totalTimeLabel
    ]).then {
      $0.axis = .horizontal
      $0.distribution = .equalSpacing
      $0.spacing = 8.0
    }
    
    [
      categoryLabel,
      titleLabel,
      firstLineStackView,
      secondLineStackView,
      separatorView,
      contentLabel
    ].forEach { addSubview($0) }
    
    categoryLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16.0)
      $0.top.equalToSuperview().inset(16.0)
    }
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(categoryLabel.snp.bottom).offset(8.0)
    }
    
    firstLineStackView.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
    }
    
    secondLineStackView.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(firstLineStackView.snp.bottom)
    }
    separatorView.snp.makeConstraints {
      $0.top.equalTo(secondLineStackView.snp.bottom).offset(8.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
      $0.height.equalTo(0.5)
    }
    
    contentLabel.snp.makeConstraints {
      $0.leading.equalTo(categoryLabel)
      $0.top.equalTo(separatorView.snp.bottom).offset(8.0)
    }
    
  }
  
  func makeLabel(
    _ title: String,
    content: String
  ) -> NSMutableAttributedString {
    let result = NSMutableAttributedString(string: title, attributes: [ .foregroundColor: UIColor.secondaryLabel, .font: UIFont.systemFont(ofSize: 12.0)])
    result.append(NSAttributedString(string: " "))
    result.append(NSMutableAttributedString(string: content, attributes: [ .foregroundColor: UIColor.label, .font: UIFont.systemFont(ofSize: 12.0)]))
    return result
  }
}
