//
//  EmailRegisterViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/14.
//

import SnapKit
import Then
import UIKit

final class EmailRegisterViewController: UIViewController {
    
//    private lazy var
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        setupNavigationBar()
        setupLayout()
    }
}

// MARK: - Private

private extension EmailRegisterViewController {
    func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = "회원가입"
    }
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
    }
}
