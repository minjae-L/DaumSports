//
//  CollectionViewCell.swift
//  DaumSports
//
//  Created by 이민재 on 2024/04/04.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 2
        label.textColor = .black
        
        return label
    }()
    private let companyTimeStampLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private func setConstraints() {
        newsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        newsImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        newsImage.heightAnchor.constraint(equalToConstant: contentView.frame.height - 20).isActive = true
        newsImage.widthAnchor.constraint(lessThanOrEqualToConstant: 130).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: companyTimeStampLabel.topAnchor, constant: -5).isActive = true
        companyTimeStampLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        companyTimeStampLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: 10).isActive = true
        companyTimeStampLabel.trailingAnchor.constraint(equalTo: newsImage.leadingAnchor, constant: -10).isActive = true
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(newsImage)
        addSubview(titleLabel)
        addSubview(companyTimeStampLabel)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: NewsContents) {
        self.titleLabel.text = model.titleName
        self.companyTimeStampLabel.text = model.company.name
        if let urlString = model.newsImage, let url = URL(string: urlString) {
            self.newsImage.kf.setImage(with: url)
        }
        
    }
}
