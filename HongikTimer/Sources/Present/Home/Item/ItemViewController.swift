//
//  ItemViewController.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/13.
//

import SnapKit
import Then
import UIKit

final class ItemViewController: UICollectionViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationbar()
    }
    
}

// MARK: - Private

private extension ItemViewController {
    func setNavigationbar() {
        navigationItem.title = "아이템"
        navigationController?.navigationBar.topItem?.title = ""
    }
}
