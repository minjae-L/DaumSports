//
//  CustomCollectionHeaderReusableView.swift
//  DaumSports
//
//  Created by 이민재 on 2024/04/08.
//

import UIKit

enum HeaderType {
    case mainSection
    case subSection
}

final class CustomCollectionHeaderReusableView: UICollectionReusableView {
    static let identifier = "CustomCollectionHeaderReusableView"
    
    private let mainLabel: UILabel =  {
        let label = UILabel()
        label.text = "전체"
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subLabel: UILabel = {
        let label = UILabel()
        label.text = "포토기사 제외"
        label.font = .systemFont(ofSize: 15)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private let button: UIButton = {
        let button = CheckBoxButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        return button
    }()
    
    private var type: HeaderType = .mainSection {
        didSet{
            configureSubSection()
        }
    }
    func configureSubSection() {
        mainLabel.isHidden = true
        mainLabel.heightAnchor.constraint(equalToConstant: 0).isActive = true
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(button)
        mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        subLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        subLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        button.trailingAnchor.constraint(equalTo: subLabel.leadingAnchor, constant: -10).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class CheckBoxButton: UIButton {
    let checkedImage = UIImage(named: "checkboxImage_filled")
    let unCheckdImage = UIImage(named: "checkboxImage")
    
    var isChecked: Bool = true {
        didSet {
            if isChecked {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(unCheckdImage, for: .normal)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.addTarget(self, action: #selector(checkButtonEvent), for: UIControl.Event.touchUpInside)
        self.isChecked = false
        self.setImage(unCheckdImage, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func checkButtonEvent() {
        isChecked = !isChecked
    }

}
