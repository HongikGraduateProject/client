//
//  EnterViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/02.
//

import UIKit
import Then
import SnapKit

final class EnterViewController: UIViewController {
  
  // MARK: - Property
  
  private lazy var  titleLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 24.0, weight: .bold)
    $0.textColor = .label
    $0.numberOfLines = 1
  }
  
  private lazy var separatorLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 12.0, weight: .regular)
    $0.text = "그룹소개"
    $0.textColor = .secondaryLabel
  }
  
  private lazy var contentLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 12.0, weight: .regular)
    $0.textColor = .label

  }
  
  private lazy var enterButton = UIButton().then {
    $0.setTitle("입장하기", for: .normal)
    $0.setTitleColor(.defaultTintColor, for: .normal)
    $0.setTitleColor(.systemBackground, for: .normal)
    $0.layer.cornerRadius = 8.0
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
    configureLayout()
    configureNavigateion()
    
    titleLabel.text  = "파이썬 코딩테스트 문제풀이 스터디 모집합니다."
    contentLabel.text = "계집애들의 별 별 별 잔디가 나는 봅니다. 하나에 별들을 파란 하나에 까닭입니다. 새겨지는 위에 토끼, 자랑처럼 나는 헤는 버리었습니다. 했던 불러 아스라히 이제 아이들의 있습니다. 이런 내일 하늘에는 새겨지는 까닭입니다. 하나에 겨울이 이름을 걱정도 내일 내린 경, 거외다. 써 나는 하나 둘 거외다."
  }
  
}

// MARK: - Method

private extension EnterViewController {
  
  func configureNavigateion() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(
      image: UIImage(systemName: "chevron.down"),
      style: .plain,
      target: self,
      action: #selector(tapLeftbarButton)
    )
  }
  
  func configureLayout() {
    [
      titleLabel,
      separatorLabel,
      contentLabel,
      enterButton
    ].forEach { view.addSubview($0) }
    
    titleLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().inset(16.0)
      $0.top.equalToSuperview().inset(16.0)
    }
    
    separatorLabel.snp.makeConstraints {
      $0.leading.equalTo(titleLabel)
      $0.top.equalTo(titleLabel.snp.bottom).offset(16.0)
    }
    
    contentLabel.snp.makeConstraints {
      $0.leading.equalTo(titleLabel)
      $0.top.equalTo(separatorLabel.snp.bottom).offset(16.0)
    }
    
    enterButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().inset(16.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
    }
  }
  
  // MARK: - Selector
  
  @objc func tapLeftbarButton() {
    dismiss(animated: true, completion: nil)
  }
  
}
