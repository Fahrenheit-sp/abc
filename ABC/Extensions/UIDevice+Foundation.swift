//
//  UIDevice+Faoundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

extension UIDevice {
    static var isiPhone: Bool {
        current.userInterfaceIdiom == .phone
    }

    static var isiPad: Bool {
        current.userInterfaceIdiom == .pad
    }
}
