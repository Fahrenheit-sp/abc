//
//  SubscriptionFeatureView.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import UIKit

final class SubscriptionFeatureView: UIView {

    private let imageView = UIImageView().disableAutoresizing()
    private let textLabel = UILabel().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(imageView)
        addSubview(textLabel)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),

            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])

        imageView.image = Asset.Subscription.check.image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .checkmark

        textLabel.numberOfLines = 0
        textLabel.textColor = .background
        textLabel.font = .systemFont(ofSize: UIScreen.isIphoneEightOrLess ? 17 : 19, weight: .medium)
    }

    func setText(to text: String) {
        textLabel.text = text
    }

}
