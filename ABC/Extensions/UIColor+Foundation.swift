//
//  UIColor+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

extension UIColor {
    static let cardGradientStart = UIColor(hex: "00BDD3")
    static let cardGradientEnd = UIColor(hex: "3D5AFE")
    static let background = UIColor(hex: "0b3f54")
    static let menuItem = UIColor(hex: "ffab40")
    static let subscribeBlue = UIColor(hex: "c1ddff")


    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let r, g, b: CGFloat

        if hex.count == 6 {
            let scanner = Scanner(string: hex)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                b = CGFloat((hexNumber & 0x0000ff) >> 0) / 255

                self.init(red: r, green: g, blue: b, alpha: alpha)
                return
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: alpha)
        return
    }
}
