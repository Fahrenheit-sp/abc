//
//  DraggableLetterView.swift
//  ABC
//
//  Created by Игорь Майсюк on 21.08.21.
//

import UIKit

protocol DraggableLetterViewDelegate: AnyObject {
    func draggableViewDidEndDragging(_ view: DraggableLetterView)
}

final class DraggableLetterView: UIView {

    private let imageView = UIImageView().disableAutoresizing()

    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(panRecognized(_:)))
        recognizer.cancelsTouchesInView = false
        return recognizer
    }()

    private var lastLocation: CGPoint = .zero
    private var startingPoint: CGPoint?

    let letter: Letter?
    weak var delegate: DraggableLetterViewDelegate?

    required init(letter: Letter?) {
        imageView.image = letter?.image
        self.letter = letter
        super.init(frame: .zero)

        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        embedSubview(imageView)
        imageView.contentMode = .scaleAspectFit

        addGestureRecognizer(panRecognizer)
    }

    @objc private func panRecognized(_ recognizer: UIPanGestureRecognizer) {
        center = recognizer.translation(in: superview) + lastLocation
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if startingPoint == nil {
            startingPoint = center
        }
        lastLocation = center
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.draggableViewDidEndDragging(self)
    }

    func reset(animated: Bool = true) {
        let setCenter = { [self] in center = startingPoint.or(center) }

        guard animated else { return setCenter() }

        UIView.animate(withDuration: 0.4) { [self] in
            setCenter()
            layoutIfNeeded()
        }
    }
}
