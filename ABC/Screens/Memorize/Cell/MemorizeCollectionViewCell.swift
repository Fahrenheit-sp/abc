//
//  MemorizeCollectionViewCell.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class MemorizeCollectionViewCell: UICollectionViewCell {

    private let cardView = CardView().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        contentView.embedSubview(cardView)
    }

    func configure(with model: MemorizeCellViewModel) {
        cardView.configure(with: model.letter)
    }
}
