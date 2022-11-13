//
//  HeaderView.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/09/27.
//

import SnapKit
import Then
import UIKit
import RxSwift

final class HeaderView: UIView {
    
//    private lazy var imageView = UIImageView(image: UIImage(systemName: "list.bullet.rectangle.fill")).then {
//        $0.contentMode = .scaleAspectFit
//    }
    
    private lazy var textLabel = UILabel().then {
        $0.text = "ToDo"
    }
    
    private lazy var plusImage = UIImageView(image: UIImage(systemName: "plus.circle")).then {
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .label
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension HeaderView {
    func setupLayout() {
        backgroundColor = .systemGray6
        
        [
//            imageView,
            textLabel,
            plusImage
        ].forEach { addSubview($0) }
        
//        imageView.snp.makeConstraints {
//            $0.leading.top.bottom.equalTo(4.0)
//            $0.height.width.equalTo(32.0)
//            $0.centerY.equalToSuperview()
//        }
        
        textLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(12.0)
            $0.height.equalTo(24.0)
            $0.trailing.equalTo(plusImage.snp.leading).offset(-4.0)
            $0.centerY.equalToSuperview()
        }
        
        plusImage.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview().inset(8.0)
            $0.height.width.equalTo(24.0)
        }
    }
}
