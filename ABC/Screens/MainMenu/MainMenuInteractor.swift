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
    private let soundPlayer: SoundPlayer
    weak var ui: MainMenuUserInterface?
    weak var router: MainMenuRoutable?

    init(parameters: MainMenuInteractor.Parameters) {
        self.parameters = parameters
        self.soundPlayer = SoundPlayer()
    }

    func didLoad() {
        soundPlayer.playMainMenuSound()
        ui?.configure(with: MainMenuScreenViewModel(items: parameters.gameItems,
                                                    isSubscribeAvailable: parameters.items.contains(.subscribe)))
    }

    func didPressEnableSound() {
        soundPlayer.resume()
    }

    func didPressDisableSound() {
        soundPlayer.pause()
    }

    func didPressSubscribe() {
        router?.mainMenuDidSelect(item: .subscribe)
    }

    func didSelectItem(at indexPath: IndexPath) {
        router?.mainMenuDidSelect(item: parameters.gameItems[indexPath.row])
    }
}
