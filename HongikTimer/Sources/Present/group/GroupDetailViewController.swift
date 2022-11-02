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
  
  private lazy var boardCollectionView = UICollectionView(
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
        forCellWithReuseIdentifier: BoardCollectionViewCell.identifier
      )
      $0.register(
        GroupDetailCell.self,
        forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
        withReuseIdentifier: BoardCollectionReusableView.idenifier
      )
      
      $0.backgroundColor = .systemGray6
    }
  
  private lazy var todayLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 32.0, weight: .medium)
    $0.textColor = .label
    $0.numberOfLines = 1
  }
  
  private lazy var totalTimeLabel = UILabel().then {
    $0.font = UIFont(name: "NotoSansCJKkr-Medium", size: 52.0)
    $0.textColor = .label
    $0.numberOfLines = 1
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
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
    UICollectionViewCell()
  }
}

extension GroupDetailViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    
  }
}

// MARK: - Metod

private extension GroupDetailViewController {
  func configureNavigationBar() {
//    navigationItem.title = "스위프트 코딩테스트 스터디"
  }
  
  func configureLayout() {
    
  }
}

