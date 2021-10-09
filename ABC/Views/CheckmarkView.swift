//
//  CheckmarkView.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import UIKit

final class CheckmarkView: UIView {

    private let checkmarkImageView = UIImageView()

    var isOn: Bool = false {
        didSet { reloadUI() }
    }
    var selectedBackgroundColor: UIColor = .subscriptionGreen
    var deselectedBackgroundColor: UIColor = .white

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        roundCornersToRound()
    }

    private func setupUI() {
        checkmarkImageView.image = Asset.Subscription.check.image
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.tintColor = .white
        embedSubview(checkmarkImageView, insets: .init(top: 2, left: 2, bottom: 2, right: 2))

        layer.borderColor = UIColor.darkGray.cgColor

        reloadUI()
    }

    private func reloadUI() {
        checkmarkImageView.isHidden = !isOn
        backgroundColor = isOn ? selectedBackgroundColor : deselectedBackgroundColor
        layer.borderWidth = isOn ? 0 : 1
    }
}
