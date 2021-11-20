//
//  MainMenuCollectionViewCell.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class MainMenuCollectionViewCell: UICollectionViewCell {

    private let background = UIView().disableAutoresizing()
    private let imageView = UIImageView().disableAutoresizing()
    private let titleLabel = UILabel().disableAutoresizing()
    private let newImageView = UIImageView().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        background.roundCorners(to: 20)

        contentView.addSubview(background)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(newImageView)

        let backgroundConstraints = background.createConstraintsForEmbedding(in: contentView)

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

        let newConstraints = [
            newImageView.centerYAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            newImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 8),
            newImageView.widthAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 44 : 64),
            newImageView.heightAnchor.constraint(equalTo: newImageView.widthAnchor)
        ]

        NSLayoutConstraint.activate(backgroundConstraints + imageConstraints + labelConstraints + newConstraints)
    }

    private func setupUI() {
        background.backgroundColor = .systemOrange
        
        imageView.contentMode = .scaleAspectFit
        newImageView.contentMode = .scaleAspectFit

        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.adjustsFontSizeToFitWidth = true
        let iPhoneSize: CGFloat = UIScreen.isiPhoneFive ? 23 : 25
        titleLabel.font = .current(size: UIDevice.isiPhone ? iPhoneSize : 29)
    }

    func configure(with model: MainMenuCellViewModel) {
        imageView.image = model.image
        titleLabel.text = model.title
        newImageView.image = model.newImage
    }
}
