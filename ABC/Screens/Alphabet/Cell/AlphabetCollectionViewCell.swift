//
//  AlphabetCollectionViewCell.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetCollectionViewCell: UICollectionViewCell {

    private let imageView = UIImageView().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.embedSubview(imageView)
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
    }

    func configure(with model: AlphabetCellViewModel) {
        imageView.image = model.image
        imageView.tintColor = model.tintColor
    }
}
