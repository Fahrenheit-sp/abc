//
//  MainMenuRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class MainMenuRouter: MainMenuRoutable {

    struct Parameters {
        let items: [MainMenuItem]
    }

    private let parameters: Parameters

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = MainMenuViewController()
        let interactor = MainMenuInteractor(parameters: .init(items: parameters.items))
        interactor.router = self
        interactor.ui = view
        view.interactor = interactor
        return view
    }

    func mainMenuDidSelect(item: MainMenuItem) {
        print("selected: \(item.title)")
    }
}
