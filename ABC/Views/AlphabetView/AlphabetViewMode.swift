//
//  AlphabetViewMode.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import UIKit

enum AlphabetViewMode {
    case numbers
    case alphabet

    var insets: UIEdgeInsets {
        switch self {
        case .numbers: return .init(top: 32, left: 32, bottom: 0, right: 32)
        case .alphabet: return .zero
        }
    }

    var spacing: CGFloat {
        switch self {
        case .numbers: return 16
        case .alphabet: return UIScreen.main.bounds.width > 400 ? 8 : 0
        }
    }
}
