//
//  MainMenuItem.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

enum MainMenuItem: CaseIterable {
    case subscribe
    case alphabet
    case numbers
    case listen
    case memorize
    case makeAWord
    case canvas

    static let gameItems = Self.allCases.filter { $0 != .subscribe }

    var title: String {
        switch self {
        case .subscribe: return L10n.Menu.Item.subscribe
        case .alphabet: return L10n.Menu.Item.alphabet
        case .numbers: return L10n.Menu.Item.numbers
        case .canvas: return L10n.Menu.Item.canvas
        case .makeAWord: return L10n.Menu.Item.makeAWord
        case .listen: return L10n.Menu.Item.listen
        case .memorize: return L10n.Menu.Item.memorize
        }
    }

    var image: ImageAsset {
        switch self {
        case .subscribe: return Asset.Menu.subscribe
        case .alphabet: return Asset.Menu.alphabet
        case .numbers: return Asset.Menu.numbers
        case .canvas: return Asset.Menu.canvas
        case .makeAWord: return Asset.Menu.makeAWord
        case .listen: return Asset.Menu.listen
        case .memorize: return Asset.Menu.memorize
        }
    }
}
