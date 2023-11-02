//
//  SubscribeRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import class UIKit.UIViewController

final class SubscribeRouter: SubscribeRoutable {

    struct Parameters {
        let purchaser: RevenueCatSubscribtionPurchaser
    }

    private let parameters: Parameters
    private weak var view: SubscribeViewController?
    private var moreOptionsRouter: Router?

    weak var delegate: SubscribeRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = SubscribeViewController()
        controller.interactor = SubscribeInteractor(ui: controller, router: self, purchaser: parameters.purchaser)

        view = controller
        return controller
    }

    func didClose() {
        view.map { delegate?.subscribeRouterDidFinishPresenting($0) }
    }

    func didTapMoreOptions() {
        let router = MoreBillingOptionsRouter(parameters: .init(purchaser: parameters.purchaser))
        router.delegate = self
        moreOptionsRouter = router

        view?.present(router.makeController(), animated: true)
    }
}

extension SubscribeRouter: MoreBillingOptionsDelegate {
    func moreOptionsRouterDidFinishPresenting(_ controller: UIViewController) {
        controller.dismiss(animated: true) { [weak self] in
            self?.parameters.purchaser.delegate = self?.view?.interactor
        }
    }
}
