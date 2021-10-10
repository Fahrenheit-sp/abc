//
//  MoreBillingOptionsRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation
import class UIKit.UIViewController

final class MoreBillingOptionsRouter: MoreBillingOptionsRoutable {

    struct Parameters {
        let fetcher: ProductsFetchable
        let purchaser: SubscriptionPurchaseable
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    weak var delegate: MoreBillingOptionsDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = MoreBillingOptionsViewController()
        controller.interactor = MoreBillingOptionsInteractor(ui: controller,
                                                             router: self,
                                                             parameters: .init(purchaser: parameters.purchaser,
                                                                               subscriptions: parameters.fetcher.getProductsInfo()))

        view = controller
        return controller
    }

    func didClose() {
        view.map { delegate?.moreOptionsRouterDidFinishPresenting($0) }
    }
}
