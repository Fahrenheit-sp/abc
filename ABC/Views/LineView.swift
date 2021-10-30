//
//  LineView.swift
//  ABC
//
//  Created by Игорь Майсюк on 30.10.21.
//

import UIKit

final class LineView: UIView {

    private var letterViews: [DraggableLetterView] = []
    private let footerView = UIView().disableAutoresizing()

    override var backgroundColor: UIColor? {
        get { footerView.backgroundColor }
        set { footerView.backgroundColor = newValue }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        addSubview(footerView)
        
        footerView.backgroundColor = .lightGray
        footerView.roundCorners(to: 1)

        NSLayoutConstraint.activate([
            footerView.heightAnchor.constraint(equalToConstant: 2),
            footerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            footerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }

    func place(_ letterView: DraggableLetterView, from point: CGPoint) {
        addSubview(letterView)
        letterView.center = convert(point, from: superview)
        letterView.delegate = self
        UIView.animate(withDuration: 0.2) {
            let scale = CGAffineTransform(scaleX: 1.75, y: 1.75)
            let yOffset: CGFloat = UIDevice.isiPhone ? 12 : 20
            let alignBottom = CGAffineTransform(translationX: 0, y: self.footerView.frame.maxY - letterView.frame.maxY - yOffset)
            letterView.transform = scale.concatenating(alignBottom)
        }
    }
}

extension LineView: DraggableLetterViewDelegate {
    func draggableViewDidEndDragging(_ letterView: DraggableLetterView) {
        let isInBounds = bounds.contains(letterView.center)
        guard !isInBounds else { return }
        letterView.reset()
    }
}
