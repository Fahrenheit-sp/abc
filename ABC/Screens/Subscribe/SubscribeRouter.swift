//
//  SubscribeRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import class UIKit.UIViewController

final class SubscribeRouter: SubscribeRoutable {

    struct Parameters {
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    weak var delegate: SubscribeRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let interactor = SubscribeInteractor()
        let controller = SubscribeViewController()
        controller.interactor = interactor

        view = controller
        return controller
    }
}
