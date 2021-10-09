//
//  SubscribeRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import class UIKit.UIViewController

final class SubscribeRouter: SubscribeRoutable {

    struct Parameters {
        let fetcher: ProductsFetchable
    }

    private let parameters: Parameters
    private weak var view: UIViewController?
    private var moreOptionsRouter: Router?

    weak var delegate: SubscribeRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = SubscribeViewController()
        controller.interactor = SubscribeInteractor(ui: controller, router: self, fetcher: parameters.fetcher)

        view = controller
        return controller
    }

    func didClose() {
        view.map { delegate?.subscribeRouterDidFinishPresenting($0) }
    }

    func didTapMoreOptions() {
        let router = MoreBillingOptionsRouter(parameters: .init(purchaser: parameters.fetcher.getPurchaser()))
        router.delegate = self
        moreOptionsRouter = router

        view?.present(router.makeController(), animated: true)
    }
}

extension SubscribeRouter: MoreBillingOptionsDelegate {
    func moreOptionsRouterDidFinishPresenting(_ controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}
