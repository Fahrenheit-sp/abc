//
//  UIFont+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 6.09.21.
//

import UIKit

extension UIFont {

    static func current(size: CGFloat = 17.0, weight: UIFont.Weight = .regular) -> UIFont {
        UIFont(name: "PlaytimeWithHotToddies", size: size).or(.systemFont(ofSize: size, weight: weight))
    }
}
