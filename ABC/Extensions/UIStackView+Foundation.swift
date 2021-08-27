//
//  UIStackView+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 27.08.21.
//

import UIKit

extension UIStackView {

    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { removeArrangedSubview($0) }
    }
}
