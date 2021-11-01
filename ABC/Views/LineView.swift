//
//  LineView.swift
//  ABC
//
//  Created by Игорь Майсюк on 30.10.21.
//

import UIKit

protocol LineViewDelegate: AnyObject {
    func lineView(_ lineView: LineView, didUpdate word: String)
    func lineView(_ lineView: LineView, didPlace letterView: DraggableLetterView)
    func lineView(_ lineView: LineView, didDelete letterView: DraggableLetterView)
}

final class LineView: UIView {

    private let footerView = UIView().disableAutoresizing()
    private var letterViews: [DraggableLetterView] {
        subviews.compactMap { $0 as? DraggableLetterView }.sorted { $0.center.x < $1.center.x }
    }
    private let insets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)

    override var backgroundColor: UIColor? {
        get { footerView.backgroundColor }
        set { footerView.backgroundColor = newValue }
    }

    weak var delegate: LineViewDelegate?

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

    private func addLetter(_ letter: Character) {
        let letterView = DraggableLetterView(letter: .init(symbol: letter))
        letterView.frame = .init(origin: .zero, size: ImageAsset(name: String(letter)).image.size)
        letterView.delegate = self
        addSubview(letterView)
    }

    func setup(word: String) {
        var shuffled = word.shuffled()
        while String(shuffled) == word {
            shuffled = word.shuffled()
        }
        shuffled.forEach { addLetter($0) }
        layoutIfNeeded()
        alignLetters()
    }

    func clear() {
        UIView.transition(with: self, duration: 0.2, options: [.transitionCrossDissolve], animations: {
            self.letterViews.forEach { $0.removeFromSuperview() }
        })
    }

    private func alignLetters() {
        let totalWidth = getLetterViewsWidth()
        let halfTotalWidth = totalWidth / 2.0
        UIView.animate(withDuration: 0.3, animations: { [self] in
            var originX = bounds.midX - halfTotalWidth
            letterViews.forEach { letterView in
                let point = CGPoint(x: originX + letterView.halfWidth, y: getYCenterCoordinate(for: letterView))
                letterView.center = point
                letterView.bind(to: point)
                originX += letterView.frame.width
            }
        }) { [self] _ in
            delegate?.lineView(self, didUpdate: getCurrentWord())
        }
    }

    private func getLetterViewsWidth() -> CGFloat {
        let totalWidth = letterViews.reduce(.zero) { $0 + $1.frame.width }
        guard bounds.width - insets.left - insets.right < totalWidth else { return totalWidth }
        let multiplier = bounds.width / (totalWidth + (insets.left * 2) + (insets.right * 2))
        letterViews.forEach { $0.transform = .init(scaleX: multiplier, y: multiplier) }
        return letterViews.reduce(.zero) { $0 + $1.frame.width }    
    }

    private func getCurrentWord() -> String {
        letterViews.compactMap { $0.letter?.symbol }.map(String.init).joined()
    }

    private func getYCenterCoordinate(for letterView: DraggableLetterView) -> CGFloat {
        footerView.frame.maxY - letterView.halfHeight
    }
}

extension LineView: DraggableLetterViewDelegate {
    func draggableViewDidEndDragging(_ letterView: DraggableLetterView) {
        bounds.contains(letterView.center) ? alignLetters() : letterView.reset()
        delegate?.lineView(self, didPlace: letterView)
    }
}
