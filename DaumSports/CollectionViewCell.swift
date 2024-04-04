//
//  CollectionViewCell.swift
//  DaumSports
//
//  Created by 이민재 on 2024/04/04.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static var identifier = "CollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
