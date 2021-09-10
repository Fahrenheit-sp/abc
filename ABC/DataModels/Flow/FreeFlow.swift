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
        let router = MainMenuRouter(parameters: .init(items: MainMenuItem.allCases), routersFabric: fabric)
        self.router = MainMenuInterstitialRouterDecorator(adaptee: router)
    }
    func start(from window: UIWindow?, animated: Bool) {
        setupRootViewController(router.makeController(), in: window, animated: animated)
    }

}
