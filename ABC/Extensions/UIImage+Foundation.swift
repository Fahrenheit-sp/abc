//
//  UIImage+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 20.08.21.
//

import UIKit

extension UIImage {
    var aspectRatio: CGFloat {
        self.size.height / self.size.width
    }
}
