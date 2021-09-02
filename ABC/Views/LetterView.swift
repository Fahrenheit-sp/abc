//
//  LetterView.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

struct LetterViewModel {
    let letter: Letter
    let tintColor: UIColor?
}

final class LetterView: UIView {

    enum State {
        case placed
        case gray
    }

    private let imageView = UIImageView().disableAutoresizing()
    private(set) var letter: Letter?
    private var state: State = .gray

    var isPlaced: Bool {
        state == .placed
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayout() {
        embedSubview(imageView)
    }

    private func setupUI() {
        imageView.contentMode = .scaleAspectFit
    }

    func configure(with model: LetterViewModel) {
        let image = model.letter.image?.withRenderingMode(model.tintColor == nil ? .alwaysOriginal : .alwaysTemplate)
        self.letter = model.letter
        
        imageView.image = image
        imageView.tintColor = model.tintColor

        self.state = model.tintColor == nil ? .placed : .gray
    }

}
