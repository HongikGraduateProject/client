//
//  GroupDetailViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/02.
//

import Foundation
import UIKit
import CoreAudioTypes

final class GroupDetailViewController: UIViewController {
  
  // MARK: - Property
  
  private lazy var purposePresentButton = UIButton().then {
    $0.backgroundColor = .systemBackground
    $0.setTitleColor(.label, for: .normal)
    $0.titleLabel?.numberOfLines = 1
    
#warning("더미")
    $0.setTitle("🔥 노년에게서 청춘은 몸이 봄바람을 안고, 열락의 실로 위하여 쓸쓸하랴? 하였으며, 있는 예가 눈에 반짝이는 별과 그리하였는가? 예수는 따뜻한 황금시대를 가는 듣는다. 바로 얼음 하는 못할 봄날의 있는가? 이것이야말로 심장의 보이는 생의 ", for: .normal)
    
  }
  
  private lazy var groupDetailCollectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: UICollectionViewFlowLayout()
  ).then {
    let layout = UICollectionViewFlowLayout()
    
    $0.collectionViewLayout = layout
    $0.showsVerticalScrollIndicator = false
    
    $0.dataSource = self
    $0.delegate = self
    
    $0.register(
      GroupDetailCell.self,
      forCellWithReuseIdentifier: GroupDetailCell.identifier
    )
    
  }
  
  private lazy var todayLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 36.0, weight: .medium)
    $0.textColor = .label
    $0.numberOfLines = 1
    $0.text = "오늘 총 공부시간"
  }
  
  private lazy var totalTimeLabel = UILabel().then {
    $0.font = UIFont(name: "NotoSansCJKkr-Medium", size: 52.0)
    $0.textColor = .label
    $0.numberOfLines = 1
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()

    configureNavigationBar()
    configureLayout()
    
    totalTimeLabel.text = "00:01:33"
    
  }
  
  // MARK: - init
  
}

// MARK: - CollectionView

extension GroupDetailViewController: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return 4
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: GroupDetailCell.idenifier, for: indexPath
    ) as? GroupDetailCell
    
    return cell ?? UICollectionViewCell()
  }
}

extension GroupDetailViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    CGSize(width: view.frame.width / 4.5, height: 116)
  }
  
}

// MARK: - Metod

private extension GroupDetailViewController {
  func configureNavigationBar() {
    navigationItem.title = "스위프트 코딩테스트 스터디"
  }
  
  func configureLayout() {
    
    view.backgroundColor = .systemBackground
    
    [
      purposePresentButton,
      groupDetailCollectionView,
      todayLabel,
      totalTimeLabel
    ].forEach { view.addSubview($0) }
    
    purposePresentButton.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide).offset(16.0)
      $0.height.equalTo(32.0)
      $0.leading.trailing.equalToSuperview().inset(16.0)
    }
    
    groupDetailCollectionView.snp.makeConstraints {
      $0.top.equalTo(purposePresentButton.snp.bottom).offset(16.0)
      $0.height.equalTo(120.0)
      $0.leading.trailing.equalToSuperview()
    }
    
    todayLabel.snp.makeConstraints {
      $0.top.equalTo(groupDetailCollectionView.snp.bottom).offset(16.0)
      $0.centerX.equalToSuperview()
    }
    
    totalTimeLabel.snp.makeConstraints {
      $0.top.equalTo(todayLabel.snp.bottom).offset(16.0)
      $0.centerX.equalToSuperview()
    }
  }
}
