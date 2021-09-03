//
//  WordView.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class WordView: UIView {

    private var stackView: UIStackView!

    override func layoutSubviews() {
        super.layoutSubviews()
        guard stackView.frame.width == 0 else { return }
        fixStackWidth()
    }

    func setWord(to word: Word) {
        stackView?.removeFromSuperview()

        let letterViews = word.letters.map { letter -> LetterView in
            let view = LetterView()
            view.configure(with: .init(letter: letter, tintColor: .lightGray))
            return view
        }

        stackView = UIStackView(arrangedSubviews: letterViews).disableAutoresizing()
        stackView.distribution = .fillProportionally
        addSubview(stackView)

        NSLayoutConstraint.activate(flexibleConstraints())
    }

    private func flexibleConstraints() -> [NSLayoutConstraint] {
        [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
    }

    private func fixedConstraints() -> [NSLayoutConstraint] {
        [
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
    }

    private func fixStackWidth() {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(fixedConstraints())
    }

    func letterView(at point: CGPoint) -> LetterView? {
        let selfPoint = stackView.convert(point, from: superview)
        return stackView.arrangedSubviews.first { $0.frame.contains(selfPoint) }.flatMap { $0 as? LetterView }
    }

    func place(_ letterView: LetterView, at targetView: LetterView, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.3) { [self] in
            letterView.frame = superview.or(self).convert(targetView.frame, from: stackView)
        } completion: { _ in
            targetView.setState(to: .placed)
            letterView.removeFromSuperview()
            completion()
        }
    }
}
