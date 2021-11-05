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
    case pictures
    case catchLetter
    case canvas
    case memorize
    case makeAWord
    case listen

    static let gameItems = Self.allCases.filter { $0 != .subscribe }

    var title: String {
        switch self {
        case .subscribe: return L10n.Menu.Item.subscribe
        case .alphabet: return L10n.Menu.Item.alphabet
        case .numbers: return L10n.Menu.Item.numbers
        case .canvas: return L10n.Menu.Item.canvas
        case .makeAWord: return L10n.Menu.Item.makeAWord
        case .listen: return L10n.Menu.Item.listen
        case .pictures: return L10n.Menu.Item.pictures
        case .catchLetter: return L10n.Menu.Item.catchLetter
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
        case .pictures: return Asset.Menu.picture
        case .catchLetter: return Asset.Menu.catchLetter
        case .memorize: return Asset.Menu.memorize
        }
    }

    var isNew: Bool {
        switch self {
        case .catchLetter, .pictures: return true
        default: return false
        }
    }
}
