//
//  ItemCollectionViewCell.swift
//  HongikTimer
//
//  Created by JongHoon on 2022/11/02.
//

import Foundation
import UIKit

final class ItemCollectionViewCell: UICollectionViewCell {
  
  lazy var categoyImageView = UIImageView().then {
    $0.contentMode = .scaleToFill

  }
  
  lazy var categoryLabel = UILabel().then {
    $0.font = .systemFont(ofSize: 12.0, weight: .medium)
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    
    backgroundColor = .red
    
    [
      categoyImageView,
      categoryLabel
    ].forEach { addSubview($0) }
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
