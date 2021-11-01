//
//  DraggableLetterView.swift
//  ABC
//
//  Created by Игорь Майсюк on 21.08.21.
//

import UIKit

protocol DraggableLetterViewDelegate: AnyObject {
    func draggableViewDidEndDragging(_ letterView: DraggableLetterView)
}

class DraggableLetterView: UIView {

    private let imageView = UIImageView().disableAutoresizing()

    private lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(panRecognized(_:)))
        recognizer.cancelsTouchesInView = false
        return recognizer
    }()

    private var lastLocation: CGPoint?
    private var startingPoint: CGPoint?

    let letter: Letter?
    weak var delegate: DraggableLetterViewDelegate?

    required init(letter: Letter?) {
        imageView.image = letter?.image
        self.letter = letter
        super.init(frame: .zero)

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if lastLocation == nil {
            lastLocation = center
        }
        if startingPoint == nil {
            startingPoint = center
        }
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
        center = recognizer.translation(in: superview) + lastLocation.or(center)
        switch recognizer.state {
        case .cancelled, .ended: delegate?.draggableViewDidEndDragging(self)
        default: return
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lastLocation = center
    }

    func bind(to point: CGPoint) {
        startingPoint = point
    }

    func reset(animated: Bool = true) {
        let setCenter = { [self] in center = startingPoint.or(center) }

        guard animated else { return setCenter() }

        UIView.animate(withDuration: 0.4) { [self] in
            setCenter()
            layoutIfNeeded()
        }
    }

    func resetWithScale(animated: Bool = true) {
        transform = .init(scaleX: 0, y: 0)
        center = startingPoint.or(center)

        let setScale = { [self] in
            transform = .identity
        }

        guard animated else { return setScale() }

        UIView.animate(withDuration: 0.4) { [self] in
            setScale()
            layoutIfNeeded()
        }
    }
}
