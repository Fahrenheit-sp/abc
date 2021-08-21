//
//  Letter.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation
import class UIKit.UIImage

struct Letter: Equatable {
    let symbol: Character
    let image: UIImage?

    init(symbol: Character) {
        self.symbol = symbol
        self.image = UIImage(named: String(symbol))
    }
}
