//
//  AlphabetCollectionViewCell.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetCollectionViewCell: UICollectionViewCell {

    private let letterView = LetterView().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.embedSubview(letterView)
    }

    func configure(with model: AlphabetCellViewModel) {
        letterView.configure(with: .init(image: model.image, tintColor: model.tintColor))
    }
}
