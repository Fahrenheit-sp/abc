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
        contentView.roundCorners(to: 20)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)

        let imageConstraints = [
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]

        let labelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ]

        NSLayoutConstraint.activate(imageConstraints + labelConstraints)
    }

    private func setupUI() {
        contentView.backgroundColor = .systemOrange
        
        imageView.contentMode = .scaleAspectFit

        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .current(size: 29)
    }

    func configure(with model: MainMenuCellViewModel) {
        imageView.image = model.image
        titleLabel.text = model.title
    }
}
