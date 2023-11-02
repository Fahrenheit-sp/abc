//
//  FreeFlow.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

struct FreeFlow: Flow {

    let router: Router

    init() {
        let fabric = DefaultRouterFabric()
        let router = MainMenuRouter(parameters: .init(items: MainMenuItem.allCases, manager: .init()), routersFabric: fabric)
        let ad = MainMenuInterstitialRouterDecorator(adaptee: router)
        let paywall = MainMenuPaywallRouterDecorator(adaptee: ad)
        self.router = paywall
    }
    func start(from window: UIWindow?, animated: Bool) {
        setupRootViewController(router.makeController(), in: window, animated: animated)
    }

}
