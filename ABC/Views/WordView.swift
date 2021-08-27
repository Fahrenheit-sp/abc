//
//  WordView.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class WordView: UIView {

    private let word: Word
    private var stackView: UIStackView!

    required init(word: Word) {
        self.word = word
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        let letterViews = word.letters.map { letter -> LetterView in
            let view = LetterView()
            view.configure(with: .init(letter: letter, tintColor: .lightGray))
            return view
        }

        stackView = UIStackView(arrangedSubviews: letterViews)
        stackView.distribution = .fillProportionally
        embedSubview(stackView)
    }

    func letterView(at point: CGPoint) -> LetterView? {
        let selfPoint = convert(point, from: superview)
        return stackView.arrangedSubviews.first { $0.frame.contains(selfPoint) }.flatMap { $0 as? LetterView }
    }
}
