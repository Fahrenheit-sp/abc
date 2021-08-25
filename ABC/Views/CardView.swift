//
//  CardView.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

final class CardView: GradientBackgroundView {

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapDetected(_:)))
        recognizer.cancelsTouchesInView = false
        return recognizer
    }()

    private let imageView = UIImageView().disableAutoresizing()
    private let backImage: UIImage

    private var isOpened = false {
        didSet { animateFlip() }
    }

    private var letter: Letter?

    required init(letter: Letter? = nil, backImage: UIImage = Asset.Games.questionMark.image) {
        self.letter = letter
        self.backImage = backImage
        super.init(frame: .zero)
        setupUI()
    }

    private func setupUI() {
        addGestureRecognizer(tapRecognizer)
        configureGradient(using: .card)
        roundCorners(to: 8)
        embedSubview(imageView, insets: .init(top: 8, left: 8, bottom: 8, right: 8))

        imageView.contentMode = .scaleAspectFit
        imageView.image = backImage
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tapDetected(_ recognizer: UITapGestureRecognizer) {
        guard !isOpened else { return }
        isOpened = true
    }

    private func animateFlip() {
        let transition: AnimationOptions = isOpened ? .transitionFlipFromLeft : .transitionFlipFromRight
        imageView.image = isOpened ? letter?.image : backImage
        UIView.transition(with: self, duration: 0.3, options: transition, animations: nil)
    }

    func flipDown() {
        guard isOpened else { return }
        isOpened = false
    }

    func configure(with letter: Letter) {
        self.letter = letter
    }
    
}
