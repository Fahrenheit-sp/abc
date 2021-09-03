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
    private var currentRouter: Router?

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
        let router: Router
        switch item {
        case .alphabet:
            router = AlphabetRouter(parameters: .init(alphabet: AlphabetsFactory.getAlphabet(.english),
                                                      configuration: .alphabet))
            let controller = router.makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        case .numbers:
            router = AlphabetRouter(parameters: .init(alphabet: AlphabetsFactory.getAlphabet(.numbers),
                                                      configuration: .numbers))
            let controller = router.makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        case .canvas:
            router = CanvasRouter(parameters: .init(canvas: AlphabetsFactory.getAlphabet(.english)))
            let controller = router.makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        case .memorize:
            router = MemorizeRouter(parameters: .init(memorizable: AlphabetsFactory.getAlphabet(.english)))
            let controller = router.makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        case .makeAWord:
            router = MakeAWordRouter(parameters: .init(canvas: AlphabetsFactory.getAlphabet(.english)))
            let controller = router.makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        case .listen:
            router = ListenRouter(parameters: .init(alphabet: AlphabetsFactory.getAlphabet(.english)))
            let controller = router.makeController()
            controller.modalPresentationStyle = .overFullScreen
            view?.present(controller, animated: true)
        }
        currentRouter = router
    }
}
