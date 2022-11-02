//
//  BoardViewController.swift
//  10-2-home
//
//  Created by JongHoon on 2022/10/14.
//

import Then
import SnapKit
import UIKit

class BoardViewController: UIViewController {
    
  private lazy var refreshControl = UIRefreshControl().then {
    $0.attributedTitle = NSAttributedString(
      string: "🐥당겨서 새로 고침!🐣",
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
    
    $0.backgroundColor = .systemGray6
  }
  
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureTabBar()
    configureLayout()
  }
}

// MARK: - Private

private extension BoardViewController {
  
  func configureTabBar() {
    
    let titleLabel = UILabel().then {
      $0.text = "Chick🔥👨‍💻"
      $0.font = .systemFont(ofSize: 16.0, weight: .bold)
    }
    let leftItem = UIBarButtonItem(customView: titleLabel)
    
    navigationItem.leftBarButtonItem = leftItem
    
  }
  
  func configureLayout() {
    [
      boardCollectionView
    ].forEach { view.addSubview($0) }
    
    boardCollectionView.snp.makeConstraints {
      $0.top.equalTo(view.safeAreaLayoutGuide)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.safeAreaLayoutGuide)
    }
  }
}










extension BoardViewController: UICollectionViewDataSource {
  
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
    
    cell?.backgroundColor = .systemBackground
    cell?.layer.cornerRadius = 8.0
    cell?.clipsToBounds = true
    
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

extension BoardViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return CGSize(width: view.frame.width, height: 160.0)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    referenceSizeForHeaderInSection section: Int
  ) -> CGSize {
    return CGSize(width: view.frame.width, height: 170.0)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    let vc = UINavigationController(rootViewController: EnterViewController())
    self.present(vc, animated: true)
  }
}

// MARK: - Private

private extension BoardViewController {
  
  // MARK: - Selector
  
  @objc func refresh() {
    refreshControl.endRefreshing()
  }
}
