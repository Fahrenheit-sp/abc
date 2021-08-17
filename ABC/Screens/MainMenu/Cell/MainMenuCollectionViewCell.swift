//
//  MainMenuCollectionViewCell.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class MainMenuCollectionViewCell: UICollectionViewCell {

    private let imageView = UIImageView().disableAutoresizing()
    private let titleLabel = UILabel().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        let imageConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8)
        ]

        let labelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]

        NSLayoutConstraint.activate(imageConstraints + labelConstraints)
    }

    private func setupUI() {
        contentView.backgroundColor = .systemOrange
        
        imageView.contentMode = .scaleAspectFit

        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
    }

    func configure(with model: MainMenuCellViewModel) {
        imageView.image = model.image
        titleLabel.text = model.title
    }
}
