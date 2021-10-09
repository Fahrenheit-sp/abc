//
//  RoundedShadowView.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import UIKit

final class RoundedShadowView: UIView {

    struct Configuration {
        let cornerRadius: CGFloat
        let shadowColor: UIColor
        let shadowOpacity: Float
        let shadowOffset: CGSize
        let shadowRadius: CGFloat
    }

    private let contentView = UIView().disableAutoresizing()
    var configuration: Configuration? {
        didSet { updateConfiguration() }
    }

    override var backgroundColor: UIColor? {
        get { contentView.backgroundColor }
        set { contentView.backgroundColor = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        embedSubview(contentView)
        backgroundColor = .white
    }

    private func updateConfiguration() {
        guard let configuration = configuration else { return }

        contentView.clipsToBounds = true
        contentView.roundCorners(to: configuration.cornerRadius)

        layer.shadowColor = configuration.shadowColor.cgColor
        layer.shadowOffset = configuration.shadowOffset
        layer.shadowOpacity = configuration.shadowOpacity
        layer.shadowRadius = configuration.shadowRadius
    }

}
