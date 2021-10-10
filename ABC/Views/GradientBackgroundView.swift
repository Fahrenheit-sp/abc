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
    override class var layerClass: AnyClass {
        CAGradientLayer.self
    }

    private var gradientLayer: CAGradientLayer {
        layer as! CAGradientLayer
    }

    func configureGradient(using configuration: GradientConfiguration) {
        gradientLayer.colors = configuration.colors.map { $0.cgColor }
        gradientLayer.startPoint = configuration.startPoint
        gradientLayer.endPoint = configuration.endPoint
    }

}
