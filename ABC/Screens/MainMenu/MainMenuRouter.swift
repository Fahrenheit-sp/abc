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
    private let fabric: RoutersFabric
    private var navigation: UINavigationController?
    private var currentRouter: Router?
    private(set) var view: MainMenuUserInterface?

    init(parameters: Parameters, routersFabric: RoutersFabric) {
        self.parameters = parameters
        self.fabric = routersFabric
        super.init()
        self.fabric.delegate = self
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

    func setInteractorDelegate(to router: MainMenuRoutable) {
        view.map { $0.interactor = makeInteractor(for: $0, router: router) }
    }

    func setFabricDelegate(to delegate: MainMenuNavigatable) {
        fabric.delegate = delegate
    }

    private func makeInteractor(for ui: MainMenuUserInterface, router: MainMenuRoutable) -> MainMenuInteractable {
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
            NSAttributedString.Key.font: UIFont.current(size: UIDevice.isiPhone ? 27 : 41)
        ]

        UINavigationBar.appearance().titleTextAttributes = attrs

        return navigationController
    }

    func mainMenuDidSelect(item: MainMenuItem) {
        let router = fabric.makeRouter(for: item)
        let controller = router.makeController()
        controller.title = item.title
        controller.navigationItem.backButtonTitle = .empty
        switch item {
        case .subscribe: navigation?.present(controller, animated: true)
        default: navigation?.pushViewController(controller, animated: true)
        }

        
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
    func alphabetRouterDidFinishPresenting(_ controller: UIViewController) {
        navigation?.popViewController(animated: true)
    }
}

extension MainMenuRouter: MakeAWordRouterDelegate {
    func makeAWordRouterDidFinishPresenting(_ controller: UIViewController) {
        navigation?.popViewController(animated: true)
    }
}

extension MainMenuRouter: MemorizeRouterDelegate {
    func memorizeRouterDidFinishPresenting(_ controller: UIViewController) {
        navigation?.popViewController(animated: true)
    }
}

extension MainMenuRouter: SubscribeRouterDelegate {
    func subscribeRouterDidFinishPresenting(_ controller: UIViewController) {
        controller.dismiss(animated: true)
    }
}
