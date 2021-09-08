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
    private var navigation: UINavigationController?
    private var currentRouter: Router?
    private(set) var view: MainMenuUserInterface?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = MainMenuViewController()
        view.navigationItem.backButtonTitle = .empty
        view.interactor = makeInteractor(for: view, router: self)
        self.view = view
        
        let navigation = makeNavigationController(with: view)
        self.navigation = navigation

        return navigation
    }

    func makeInteractor(for ui: MainMenuUserInterface, router: MainMenuRoutable) -> MainMenuInteractable {
        let interactor = MainMenuInteractor(parameters: .init(items: parameters.items))
        interactor.router = router
        interactor.ui = ui
        return interactor
    }

    private func makeNavigationController(with view: UIViewController) -> UINavigationController {
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
        navigation?.pushViewController(controller, animated: true)
        
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
        navigation?.popViewController(animated: true)
    }
}

extension MainMenuRouter: MakeAWordRouterDelegate {
    func makeAWordRouterDidFinish(_ router: Router) {
        navigation?.popViewController(animated: true)
    }
}

extension MainMenuRouter: MemorizeRouterDelegate {
    func memorizeRouterDidFinish(_ router: Router) {
        navigation?.popViewController(animated: true)
    }
}
