//
//  FreeFlow.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

struct FreeFlow: Flow {
    func start(from window: UIWindow?, animated: Bool) {
        let fabric = DefaultRouterFabric()
        let router = MainMenuRouter(parameters: .init(items: MainMenuItem.allCases), routersFabric: fabric)
        let adapter = MainMenuInterstitialRouterDecorator(adaptee: router)
        let controller = adapter.makeController()
        setupRootViewController(controller, in: window, animated: animated)
    }

}
