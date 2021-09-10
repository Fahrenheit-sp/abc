//
//  SubscribedFlow.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

struct SubscribedFlow: Flow {
    func start(from window: UIWindow?, animated: Bool) {
        let router = MainMenuRouter(parameters: .init(items: MainMenuItem.gameItems), routersFabric: DefaultRouterFabric())
        setupRootViewController(router.makeController(), in: window, animated: animated)
    }
}
