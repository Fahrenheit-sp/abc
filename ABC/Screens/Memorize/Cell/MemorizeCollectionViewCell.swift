//
//  MemorizeCollectionViewCell.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

protocol MemorizeCellDelegate: AnyObject {
    func cell(_ memorizeCell: MemorizeCollectionViewCell, didFinishAnimatingTo isOpened: Bool)
}

final class MemorizeCollectionViewCell: UICollectionViewCell {

    private let cardView = CardView().disableAutoresizing()
    override var isSelected: Bool {
        get { super.isSelected }
        set {
            super.isSelected = newValue
            guard newValue else { return }
            cardView.flipUp()
        }
    }

    weak var delegate: MemorizeCellDelegate?

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
        cardView.delegate = self
    }

    func hide(animated: Bool = true) {
        let changeAlpha = { [self] in cardView.alpha = 0 }
        guard animated else { return changeAlpha() }
        UIView.animate(withDuration: 0.3, animations: changeAlpha)
    }

    func flipBack(animated: Bool = true) {
        cardView.flipDown()
    }
}

extension MemorizeCollectionViewCell: CardViewDelegate {
    func cardView(_ cardView: CardView, didFinishAnimationTo isOpened: Bool) {
        delegate?.cell(self, didFinishAnimatingTo: isOpened)
    }
}
