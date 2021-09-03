//
//  MainMenuItem.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

enum MainMenuItem: CaseIterable {
    case alphabet
    case numbers
    case canvas
    case makeAWord
    case catchALetter
    case memorize

    var title: String {
        switch self {
        case .alphabet: return L10n.Menu.Item.alphabet
        case .numbers: return L10n.Menu.Item.numbers
        case .canvas: return L10n.Menu.Item.canvas
        case .makeAWord: return L10n.Menu.Item.makeAWord
        case .catchALetter: return L10n.Menu.Item.catchALetter
        case .memorize: return L10n.Menu.Item.memorize
        }
    }
}
