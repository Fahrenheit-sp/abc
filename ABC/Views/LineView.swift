//
//  LineView.swift
//  ABC
//
//  Created by Игорь Майсюк on 30.10.21.
//

import UIKit

final class LineView: UIView {

    private let footerView = UIView().disableAutoresizing()
    private var letterViews: [DraggableLetterView] {
        subviews.compactMap { $0 as? DraggableLetterView }.sorted { $0.center.x < $1.center.x }
    }

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
        UIView.animate(withDuration: 0.3) {
            letterView.transform = .init(scaleX: 1.5, y: 1.5)
            self.alignHorizontally(letterView)
        }
    }

    private func alignHorizontally(_ letterView: DraggableLetterView) {
        let letterViews = allLetterViews(except: letterView)
        let isFirst = letterViews.isEmpty
        guard !isFirst else { return placeFirstLetterView(letterView) }
        alignIntersections()
    }

    private func placeFirstLetterView(_ letterView: DraggableLetterView) {
        let point = CGPoint(x: bounds.midX, y: getYCenterCoordinate(for: letterView))
        letterView.center = point
        letterView.bind(to: point)
    }

    private func alignIntersections(animated: Bool = false) {
        let align = { [self] in
            var originX: CGFloat = .zero
            letterViews.enumerated().forEach { index, letterView in
                let point = CGPoint(x: originX + letterView.halfWidth, y: getYCenterCoordinate(for: letterView))
                letterView.center = point
                letterView.bind(to: point)
                originX += letterView.frame.width
            }
        }
        guard animated else { return align() }
        UIView.animate(withDuration: 0.3, animations: align)
    }

    private func allLetterViews(except current: DraggableLetterView) -> [DraggableLetterView] {
        letterViews.filter { $0 != current }
    }

    private func getYCenterCoordinate(for letterView: DraggableLetterView) -> CGFloat {
        footerView.frame.maxY - letterView.halfHeight
    }
}

extension LineView: DraggableLetterViewDelegate {
    func draggableViewDidEndDragging(_ letterView: DraggableLetterView) {
        let isInBounds = bounds.contains(letterView.center)
        guard !isInBounds else { return alignIntersections(animated: true) }
        letterView.reset()
    }
}

extension LineView: DeletableLetterViewDelegate {
    func deletableLetterViewDidDelete(_ letterView: DeletableLetterView) {
        alignIntersections(animated: true)
    }
}
