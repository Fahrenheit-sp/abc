//
//  UIView+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

extension UIView {
    func disableAutoresizing() -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    func embedSubview(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        NSLayoutConstraint.activate(subview.createConstraintsForEmbedding(in: self, insets: insets))
    }

    func createConstraintsForEmbedding(in view: UIView,
                                              insets: UIEdgeInsets = .zero,
                                              priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        return [
            topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).with(priority: priority),
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).with(priority: priority),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).with(priority: priority),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right).with(priority: priority)
        ]
    }

    func roundCorners(to radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
}


extension NSLayoutConstraint {

    func with(priority: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = priority
        return self
    }
}
