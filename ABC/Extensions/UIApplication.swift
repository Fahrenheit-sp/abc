//
//  UIApplication.swift
//  ABC
//
//  Created by Igor Maisiuk on 23.09.25.
//

import UIKit

extension UIApplication {
    var keyScene: UIWindowScene? {
        connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene
    }
}
