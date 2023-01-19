//
//  UIFont+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 6.09.21.
//

import UIKit

extension UIFont {

    static func current(size: CGFloat = 17.0, weight: UIFont.Weight = .regular) -> UIFont {
        let name = Locale.preferredLanguages[0].contains("ru") ? "AntipastoPro-Demibold" : "PlaytimeWithHotToddies"
        return UIFont(name: name, size: size).or(.systemFont(ofSize: size, weight: weight))
    }
}
