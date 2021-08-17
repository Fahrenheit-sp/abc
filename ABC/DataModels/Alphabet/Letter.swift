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

    var image: UIImage? {
        UIImage(named: String(symbol))
    }
}
