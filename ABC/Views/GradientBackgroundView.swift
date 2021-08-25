//
//  GradientBackgroundView.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

class GradientBackgroundView: UIView {

    struct GradientConfiguration {
        let colors: [UIColor]
        let startPoint: CGPoint
        let endPoint: CGPoint

        static let card = Self.init(colors: [.cardGradientStart, .cardGradientEnd],
                                    startPoint: .init(x: 0.5, y: 0),
                                    endPoint: .init(x: 0.5, y: 1))
    }
    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func setupGradientLayer() {
        gradientLayer.masksToBounds = true
        layer.insertSublayer(gradientLayer, at: 0)
    }

    func configureGradient(using configuration: GradientConfiguration) {
        gradientLayer.colors = configuration.colors.map { $0.cgColor }
        gradientLayer.startPoint = configuration.startPoint
        gradientLayer.endPoint = configuration.endPoint
    }

}
