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
    }

    let parameters: Parameters
    weak var ui: MainMenuUserInterface?
    var router: MainMenuRoutable?

    init(parameters: MainMenuInteractor.Parameters) {
        self.parameters = parameters
    }

    func didLoad() {
        ui?.configure(with: MainMenuScreenViewModel(items: parameters.items))
    }

    func didSelectItem(at indexPath: IndexPath) {
        router?.mainMenuDidSelect(item: parameters.items[indexPath.row])
    }
}
