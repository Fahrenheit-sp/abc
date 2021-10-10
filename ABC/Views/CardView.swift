//
//  CardView.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

protocol CardViewDelegate: AnyObject {
    func cardView(_ cardView: CardView, didFinishAnimationTo isOpened: Bool)
}

final class CardView: GradientBackgroundView {

    private let imageView = UIImageView().disableAutoresizing()
    private let backImage: UIImage

    private var isOpened = false {
        didSet { animateFlip() }
    }

    private var letter: Letter?
    weak var delegate: CardViewDelegate?

    required init(letter: Letter? = nil, backImage: UIImage = Asset.Games.questionMark.image) {
        self.letter = letter
        self.backImage = backImage
        super.init(frame: .zero)
        setupUI()
    }

    private func setupUI() {
        configureGradient(using: .card)
        roundCorners(to: UIDevice.isiPhone ? 8 : 16)
        let offset: CGFloat = UIDevice.isiPhone ? 16 : 24
        embedSubview(imageView, insets: .init(top: offset, left: offset / 2, bottom: offset, right: offset / 2))

        imageView.contentMode = .scaleAspectFit
        imageView.image = backImage
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func animateFlip() {
        let transition: AnimationOptions = isOpened ? .transitionFlipFromLeft : .transitionFlipFromRight
        imageView.image = isOpened ? letter?.image : backImage
        UIView.transition(with: self, duration: 0.3, options: transition, animations: nil) { [self] _ in
            delegate?.cardView(self, didFinishAnimationTo: isOpened)
        }
    }

    func flipUp() {
        guard !isOpened else { return }
        isOpened = true
    }

    func flipDown() {
        guard isOpened else { return }
        isOpened = false
    }

    func configure(with letter: Letter) {
        self.letter = letter
    }
    
}
