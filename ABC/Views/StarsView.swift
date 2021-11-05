//
//  StarsView.swift
//  ABC
//
//  Created by Игорь Майсюк on 27.08.21.
//

import UIKit

final class StarsView: UIView {

    struct Configuration {
        var numberOfFilled: Int
        var numberOfEmpty: Int
        let maximum: Int

        init(numberOfFilled: Int, numberOfEmpty: Int) {
            self.numberOfEmpty = numberOfEmpty
            self.numberOfFilled = numberOfFilled
            self.maximum = numberOfEmpty + numberOfFilled
        }

        static let `default` = Self.init(numberOfFilled: 0, numberOfEmpty: 5)
    }

    private let stackView = UIStackView()
    private var configuration: Configuration = .default

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 12

        embedSubview(stackView)
    }

    private func reloadStackView() {
        stackView.removeAllArrangedSubviews()

        let filled = (0..<configuration.numberOfFilled).map { _ in getFilledImageView() }
        let empty = (0..<configuration.numberOfEmpty).map { _ in getEmptyImageView() }

        (filled + empty).forEach { stackView.addArrangedSubview($0) }

        UIView.transition(with: stackView, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }

    func configure(with configuration: Configuration = .default) {
        self.configuration = configuration
        reloadStackView()
    }

    func increaseFilledCount() {
        configuration.numberOfFilled = min(configuration.maximum, configuration.numberOfFilled + 1)
        configuration.numberOfEmpty = max(0, configuration.numberOfEmpty-1)
        reloadStackView()
    }

    func decreaseFilledCount() {
        configuration.numberOfFilled = max(0, configuration.numberOfFilled-1)
        configuration.numberOfEmpty = min(configuration.maximum, configuration.numberOfEmpty + 1)
        reloadStackView()
    }

    private func getFilledImageView() -> UIImageView {
        let imageView = UIImageView(image: Asset.Games.starFilled.image).disableAutoresizing()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        return imageView
    }

    private func getEmptyImageView() -> UIImageView {
        let imageView = UIImageView(image: Asset.Games.starEmpty.image).disableAutoresizing()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        return imageView
    }
}
