//
//  BoardViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import Then
import SnapKit
import UIKit

final class BoardViewController: UIViewController {
    
    private lazy var popularBoardView = PopularBoardView()
    private lazy var interestBoardView = InterestBoardView()
    
    private lazy var writeButton = UIButton().then {
        $0.setImage(UIImage(
            systemName: "square.and.pencil"),
                    for: .normal
        )
        $0.imageView?.tintColor = .white
        $0.backgroundColor = .timerGreen
        $0.layer.cornerRadius = 28.0
        $0.addTarget(
            self,
            action: #selector(tapWriteButton),
            for: .touchUpInside
        )
    }
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupLayout()
    }
    
} 

// MARK: - Private

private extension BoardViewController {
    
    func setupLayout() {
        view.backgroundColor = .systemGray6

        [
            popularBoardView,
            interestBoardView,
            writeButton
        ].forEach { view.addSubview($0) }
        
        popularBoardView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(252.0)
        }
        
        interestBoardView.snp.makeConstraints {
            $0.top.equalTo(popularBoardView.snp.bottom).offset(16.0)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        writeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16.0)
            $0.width.height.equalTo(56.0)
        }
        
        writeButton.imageView?.snp.makeConstraints {
            $0.width.height.equalTo(32.0)
        }
    }
    
// MARK: - Selector
    
    @objc func tapWriteButton() {
        print("tap write button")
    }
}
