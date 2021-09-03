//
//  WordView.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class WordView: UIView {

    private let stackView = UIStackView().disableAutoresizing()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor),
            stackView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    func setWord(to word: Word) {
        stackView.removeAllArrangedSubviews()

        let letterViews = word.letters.map { letter -> LetterView in
            let view = LetterView()
            view.configure(with: .init(letter: letter, tintColor: .lightGray))
            return view
        }
        letterViews.forEach { stackView.addArrangedSubview($0) }
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
