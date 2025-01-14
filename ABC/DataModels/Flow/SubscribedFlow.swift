//
//  SubscribedFlow.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

struct SubscribedFlow: Flow {

    let router: Router

    init() {
        self.router = MainMenuRouter(parameters: .init(items: MainMenuItem.gameItems, manager: .init()), routersFabric: DefaultRouterFabric())
    }
    func start(from window: UIWindow?, animated: Bool) {
        setupRootViewController(router.makeController(), in: window, animated: animated)
    }
}
