//
//  DeletableLetterView.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

final class DeletableLetterView: DraggableLetterView {

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(tapDetected(_:)))
        recognizer.cancelsTouchesInView = false
        return recognizer
    }()

    required init(letter: Letter?) {
        super.init(letter: letter)
        addGestureRecognizer(tapRecognizer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tapDetected(_ recognizer: UITapGestureRecognizer) {
        removeFromSuperview()
    }

}
