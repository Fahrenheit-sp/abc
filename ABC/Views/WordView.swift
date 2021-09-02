//
//  WordView.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class WordView: UIView {

    private let stackView = UIStackView().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.distribution = .fillProportionally
        embedSubview(stackView)
    }

    func setWord(to word: Word) {
        stackView.removeAllArrangedSubviews()

        let letterViews = word.letters.map { letter -> LetterView in
            let view = LetterView()
            view.configure(with: .init(letter: letter, tintColor: .lightGray))
            return view
        }
        letterViews.forEach { stackView.addArrangedSubview($0) }
    }

    func letterView(at point: CGPoint) -> LetterView? {
        let selfPoint = convert(point, from: superview)
        return stackView.arrangedSubviews.first { $0.frame.contains(selfPoint) }.flatMap { $0 as? LetterView }
    }
}
