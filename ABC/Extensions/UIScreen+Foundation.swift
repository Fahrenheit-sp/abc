//
//  UIScreen+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 7.09.21.
//

import UIKit

extension UIScreen {

    static var width: CGFloat {
        main.bounds.width
    }

    static var height: CGFloat {
        main.bounds.height
    }

    static var isiPhoneFive: Bool {
        width == 320
    }
}
