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
    
    private lazy var boardView = BoardView()
    
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
            boardView
        ].forEach { view.addSubview($0) }
        
        boardView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

