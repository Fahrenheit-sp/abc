//
//  MainMenuRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class MainMenuRouter: NSObject, MainMenuRoutable {

    struct Parameters {
        let items: [MainMenuItem]
    }

    private let parameters: Parameters
    private var view: UINavigationController?
    private var currentRouter: Router?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = MainMenuViewController()
        view.navigationItem.backButtonTitle = .empty

        let interactor = MainMenuInteractor(parameters: .init(items: parameters.items))
        interactor.router = self
        interactor.ui = view
        view.interactor = interactor

        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.backIndicatorImage = Asset.Icons.back.image
        navigationController.navigationBar.backIndicatorTransitionMaskImage = Asset.Icons.back.image
        navigationController.interactivePopGestureRecognizer?.isEnabled = false
        navigationController.view.backgroundColor = .clear

        navigationController.delegate = self

        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.current(size: 27)
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs

        self.view = navigationController

        return navigationController
    }

    func mainMenuDidSelect(item: MainMenuItem) {

        let router: Router
        switch item {
        case .alphabet, .numbers:
            let alphabet = item == .alphabet ? AlphabetsFactory.getAlphabet(.english) : AlphabetsFactory.getAlphabet(.numbers)
            let mode: AlphabetViewMode = item == .alphabet ? .alphabet : .numbers
            let alphabetRouter = AlphabetRouter(parameters: .init(alphabet: alphabet, mode: mode))
            alphabetRouter.delegate = self
            router = alphabetRouter
        case .canvas:
            router = CanvasRouter(parameters: .init(canvas: AlphabetsFactory.getAlphabet(.english)))
        case .memorize:
            let memorizeRouter = MemorizeRouter(parameters: .init(memorizable: AlphabetsFactory.getAlphabet(.english)))
            memorizeRouter.delegate = self
            router = memorizeRouter
        case .makeAWord:
            let makeAWordRouter = MakeAWordRouter(parameters: .init(canvas: AlphabetsFactory.getAlphabet(.english)))
            makeAWordRouter.delegate = self
            router = makeAWordRouter
        case .listen:
            router = ListenRouter(parameters: .init(alphabet: AlphabetsFactory.getAlphabet(.english),
                                                    mode: .alphabet))
        }

        let controller = router.makeController()
        controller.title = item.title
        controller.navigationItem.backButtonTitle = .empty
        view?.pushViewController(controller, animated: true)
        
        currentRouter = router
    }
}

extension MainMenuRouter: UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController, animated: Bool) {
        navigationController.isNavigationBarHidden = viewController is MainMenuViewController
    }
}

extension MainMenuRouter: AlphabetRouterDelegate {
    func alphabetRouterDidFinish(_ router: Router) {
        view?.popViewController(animated: true)
    }
}

extension MainMenuRouter: MakeAWordRouterDelegate {
    func makeAWordRouterDidFinish(_ router: Router) {
        view?.popViewController(animated: true)
    }
}

extension MainMenuRouter: MemorizeRouterDelegate {
    func memorizeRouterDidFinish(_ router: Router) {
        view?.popViewController(animated: true)
    }
}
