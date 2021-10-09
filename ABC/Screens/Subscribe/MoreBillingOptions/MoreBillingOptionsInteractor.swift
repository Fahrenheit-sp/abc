//
//  MoreBillingOptionsInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation

final class MoreBillingOptionsInteractor {

    struct Parameters {
        let billingOptions: [BillingOption]
    }

    private weak var ui: MoreBillingOptionsUserInterface?
    private weak var router: MoreBillingOptionsRoutable?
    private let purchaser: SubscriptionPurchaseable

    init(ui: MoreBillingOptionsUserInterface? = nil,
         router: MoreBillingOptionsRoutable? = nil,
         purchaser: SubscriptionPurchaseable) {
        self.ui = ui
        self.router = router
        self.purchaser = purchaser
        self.purchaser.delegate = self
    }
}

extension MoreBillingOptionsInteractor: MoreBillingOptionsInteractable {
    func didLoad() {
        #warning("Handle billing options")
    }

    func didClose() {
        router?.didClose()
    }

    func didTapBuyMain() {
        purchaser.buyYearSubscription()
    }

    func didTapBuySecondary() {
        purchaser.buyMonthSubscription()
    }

}

extension MoreBillingOptionsInteractor: SubscriptionPurchaserDelegate {
    func purchaser(_ purchaser: SubscriptionPurchaseable, didFailToPurchaseWith error: Error) {
        #warning("Handle purchases")
    }

    func purchaser(_ purchaser: SubscriptionPurchaseable, didSubscribeSuccesfullyUntil date: Date?) {

    }

    func purchaser(_ purchaser: SubscriptionPurchaseable, didRestoreSuccesfullyUntil date: Date?) {

    }

    func purchaserDidCancelPurchase(_ purchaser: SubscriptionPurchaseable) {

    }
}
