//
//  DraggableLetterView.swift
//  ABC
//
//  Created by Игорь Майсюк on 21.08.21.
//

import UIKit

final class DraggableLetterView: UIView {

    private let imageView = UIImageView().disableAutoresizing()
    private lazy var panRecognizer: UIPanGestureRecognizer = {
        UIPanGestureRecognizer(target: self, action: #selector(panRecognized(_:)))
    }()
    private let anchorPoint: CGPoint

    required init(image: UIImage?, anchorPoint: CGPoint) {
        imageView.image = image
        self.anchorPoint = anchorPoint
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        embedSubview(imageView)
    }

    @objc private func panRecognized(_ recognizer: UIPanGestureRecognizer) {
        print("pan recognized")
    }
}
