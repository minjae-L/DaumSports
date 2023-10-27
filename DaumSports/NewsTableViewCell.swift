//
//  NewsTableViewCell.swift
//  DaumSports
//
//  Created by 이민재 on 2023/10/27.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    private let titleLabel: UILabel = {
       let lb = UILabel()
        lb.numberOfLines = 2
        lb.translatesAutoresizingMaskIntoConstraints = false
        
        return lb
    }()
    
    private let subInfoLabel: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 1
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.textColor = .lightGray
        lb.font = UIFont.systemFont(ofSize: 12)
        
        return lb
    }()

    
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        
        return imgView
    }()
    
    private func setLayout() {
        let widthSize: CGFloat = contentView.frame.size.width
        let heightSize: CGFloat = contentView.frame.size.height
        
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subInfoLabel.topAnchor, constant: -5).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: -10).isActive = true
        
        subInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        subInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        subInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        subInfoLabel.trailingAnchor.constraint(equalTo: imgView.leadingAnchor, constant: -10).isActive = true

        imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        imgView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15).isActive = true
        imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        imgView.widthAnchor.constraint(equalToConstant: widthSize / 2.5).isActive = true
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imgView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subInfoLabel)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
        subInfoLabel.text = nil
        imgView.image = nil
    }

    func configure(with model: Contents) {
        titleLabel.text = model.title
        subInfoLabel.text = model.cp.cpName
        imgView.load(url: URL(string: model.thumbnailUrl)!)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.sync {
                        self?.image = image
                    }
                }
            }
        }
    }
}
