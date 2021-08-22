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
    private weak var view: UIViewController?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = MainMenuViewController()
        let interactor = MainMenuInteractor(parameters: .init(items: parameters.items))
        interactor.router = self
        interactor.ui = view
        view.interactor = interactor

        self.view = view

        return view
    }

    func mainMenuDidSelect(item: MainMenuItem) {
        switch item {
        case .alphabet:
            let controller = AlphabetRouter(parameters: .init(alphabet: English())).makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        case .numbers:
            let controller = AlphabetRouter(parameters: .init(alphabet: Numbers())).makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        case .games:
            let router = MainMenuRouter(parameters: .init(items: [.catchALetter, .memorize, .makeAWord]))
            view?.present(router.makeController(), animated: true)
        default:
            view?.present(UIViewController(), animated: true)
        }
    }
}
