//
//  MainMenuInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

final class MainMenuInteractor: MainMenuInteractable {

    struct Parameters {
        let items: [MainMenuItem]

        var gameItems: [MainMenuItem] {
            items.filter { $0 != .subscribe }
        }
    }

    private let parameters: Parameters
    weak var ui: MainMenuUserInterface?
    weak var router: MainMenuRoutable?

    init(parameters: MainMenuInteractor.Parameters) {
        self.parameters = parameters
    }

    func didLoad() {
        ui?.configure(with: MainMenuScreenViewModel(items: parameters.gameItems,
                                                    isSubscribeAvailable: parameters.items.contains(.subscribe)))
    }

    func didPressSubscribe() {
        router?.mainMenuDidSelect(item: .subscribe)
    }

    func didSelectItem(at indexPath: IndexPath) {
        router?.mainMenuDidSelect(item: parameters.gameItems[indexPath.row])
    }
}
