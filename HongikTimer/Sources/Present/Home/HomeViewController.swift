//
//  HomeViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import SnapKit
import Then
import UIKit
import ReactorKit
import RxCocoa

final class HomeViewController: BaseViewController {
  
  let reactor: HomeViewReactor
  
  var purpose: String? = "목표를 입력하세요!" {
    didSet {
      purposeView.setPurpose(with: purpose ?? "")
    }
  }
  
  private lazy var wallpaperImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  private lazy var houseImageView = UIImageView().then {
    $0.contentMode = .scaleAspectFill
  }
  
  private lazy var purposeView = PurposeView(purpose: purpose ?? "").then {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(tapPurposeView)
    )
    $0.addGestureRecognizer(tap)
    $0.isUserInteractionEnabled = true
  }
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setNavigationbar()
    setupLayout()
    bind(reactor: self.reactor)
    
    // MARK: - dummy
    wallpaperImageView.image = UIImage(named: "w6")
    houseImageView.image = UIImage(named: "Home_ex2")
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  // MARK: - Init
  
  init(_ reactor: HomeViewReactor) {
    self.reactor = reactor
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

// MARK: - Bind

extension HomeViewController: View {
  func bind(reactor: HomeViewReactor) {

  }
}

// MARK: - Method

private extension HomeViewController {
  func setNavigationbar() {
    navigationItem.title = "Home"
    
    let settingBarButton = UIBarButtonItem(
      image: UIImage(systemName: "gearshape"),
      style: .plain,
      target: self,
      action: #selector(tapSettingButton)
    )
    
    navigationItem.leftBarButtonItem = settingBarButton
    
    let notificationBarButton = UIBarButtonItem(
      image: UIImage(systemName: "bell"),
      style: .plain,
      target: self,
      action: #selector(tapNotificationButton)
    )
    
    let itemBarButton = UIBarButtonItem(
      image: UIImage(systemName: "paintpalette"),
      style: .plain,
      target: self,
      action: #selector(tapItemButton)
    )
    
    navigationItem.rightBarButtonItems = [itemBarButton, notificationBarButton]
  }
  
  func setupLayout() {
    [
      wallpaperImageView,
      houseImageView,
      purposeView
    ].forEach { view.addSubview($0) }
    
    wallpaperImageView.snp.makeConstraints {
      $0.top.equalToSuperview()
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(view.snp_bottomMargin)
    }
    
    houseImageView.snp.makeConstraints {
      $0.top.equalToSuperview().inset(300.0)
      $0.width.height.equalTo(280.0)
      $0.centerX.equalToSuperview()
    }
    
    purposeView.snp.makeConstraints {
      $0.bottom.equalTo(houseImageView.snp.top).offset(32.0)
      $0.leading.trailing.equalToSuperview().inset(32.0)
      $0.centerX.equalToSuperview()
      $0.height.equalTo(100.0)
    }
  }
  
  // MARK: - Selector
  
  @objc func tapPurposeView() {
    let vc = SetPurposeViewController()
    vc.textCompletion = { purpose in
      self.purpose = purpose
    }
    
    let nv = UINavigationController(rootViewController: vc)
    nv.modalPresentationStyle = .overCurrentContext
    present(nv, animated: true)
  }
  
  @objc func tapSettingButton() {
    let vc = SettingViewController()
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func tapNotificationButton() {
    let vc = NotificationViewController(
      collectionViewLayout: UICollectionViewFlowLayout()
    )
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc func tapItemButton() {
    let vc = ItemViewController(
      collectionViewLayout: UICollectionViewFlowLayout()
    )
    navigationController?.pushViewController(vc, animated: true)
  }
}
