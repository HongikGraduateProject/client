//
//  BoardViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import UIKit

final class BoardViewController: UIViewController {
    
    private lazy var popularBoardView = PopularBoardView()
    private lazy var interestBoardView = InterestBoardView()
    
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
            interestBoardView
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
    }
}
