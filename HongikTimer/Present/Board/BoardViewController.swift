//
//  BoardViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/10/12.
//

import UIKit

final class BoardViewController: UIViewController {
    
    private lazy var popularBoardView = PopularBoardView()
    
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
            popularBoardView
        ].forEach { view.addSubview($0) }
        
        popularBoardView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(252.0)
        }
    }
}
