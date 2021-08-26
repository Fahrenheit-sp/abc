//
//  LetterView.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

struct LetterViewModel {
    let image: UIImage?
    let tintColor: UIColor?
}

final class LetterView: UIView {

    private let imageView = UIImageView().disableAutoresizing()

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
        imageView.image = model.image?.withRenderingMode(model.tintColor == nil ? .alwaysOriginal : .alwaysTemplate)
        imageView.tintColor = model.tintColor
    }

}
