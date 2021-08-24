//
//  CanvasAlphabetView.swift
//  ABC
//
//  Created by Игорь Майсюк on 24.08.21.
//

import UIKit

final class CanvasAlphabetView: UIView {

    private let topStack = UIStackView().disableAutoresizing()
    private let middleStack = UIStackView().disableAutoresizing()
    private let bottomStack = UIStackView().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureStacks()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(topStack)
        addSubview(middleStack)
        addSubview(bottomStack)

        let topConstraints = [
            topStack.topAnchor.constraint(equalTo: topAnchor),
            topStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            topStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            topStack.bottomAnchor.constraint(equalTo: middleStack.topAnchor)
        ]

        let middleConstraints = [
            middleStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            middleStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            middleStack.bottomAnchor.constraint(equalTo: bottomStack.topAnchor)
        ]

        let bottomConstraints = [
            bottomStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]

        let heightConstraints = [
            topStack.heightAnchor.constraint(equalTo: middleStack.heightAnchor),
            middleStack.heightAnchor.constraint(equalTo: bottomStack.heightAnchor)
        ]

        NSLayoutConstraint.activate(topConstraints + middleConstraints + bottomConstraints + heightConstraints)
    }

    private func configureStacks() {
        [topStack, middleStack, bottomStack].forEach {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fillProportionally
            $0.spacing = 0
        }
    }

    func configure(with model: CanvasViewModel) {
        let letterViews = (0..<model.numberOfRows)
            .map { model.letters(in: $0).map { DraggableLetterView(letter: $0) } }
        assert(letterViews.count == 3, "Not 3 rows in canvas")
        letterViews[0].forEach { topStack.addArrangedSubview($0) }
        letterViews[1].forEach { middleStack.addArrangedSubview($0) }
        letterViews[2].forEach { bottomStack.addArrangedSubview($0) }
    }
}
