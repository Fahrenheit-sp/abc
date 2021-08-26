//
//  WordView.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class WordView: UIView {

    private let word: Word

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
            let view = LetterView().disableAutoresizing()
            view.configure(with: .init(image: letter.image, tintColor: .lightGray))
            return view
        }

        let stackView = UIStackView(arrangedSubviews: letterViews).disableAutoresizing()
        stackView.distribution = .fillProportionally
        embedSubview(stackView)
    }
}
