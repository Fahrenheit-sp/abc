//
//  MoreBillingOptionsInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation

final class MoreBillingOptionsInteractor {

    struct Parameters {
        let purchaser: SubscriptionPurchaseable
        let subscriptions: [SubscriptionInfo]
    }

    private weak var ui: MoreBillingOptionsUserInterface?
    private weak var router: MoreBillingOptionsRoutable?
    private let parameters: Parameters
    private var selectedSubscriptionInfo: SubscriptionInfo?

    init(ui: MoreBillingOptionsUserInterface? = nil,
         router: MoreBillingOptionsRoutable? = nil,
         parameters: Parameters) {
        self.ui = ui
        self.router = router
        self.parameters = parameters
        self.parameters.purchaser.delegate = self
        self.selectedSubscriptionInfo = getMainSubscriptionInfo()
    }
}

extension MoreBillingOptionsInteractor: MoreBillingOptionsInteractable {
    func didLoad() {
        let main = getMainSubscriptionInfo()
        let secondary = getSecondarySubscriptionInfo()
        ui?.configure(with: .init(mainBillingOption: .init(subscriptionInfo: main, isSelected: true),
                                  secondaryBillingOption: .init(subscriptionInfo: secondary, isSelected: false)))
    }

    func didClose() {
        router?.didClose()
    }

    func didSelectMain() {
        selectedSubscriptionInfo = getMainSubscriptionInfo()
        ui?.configure(with: .init(mainBillingOption: <#T##BillingOption?#>, secondaryBillingOption: <#T##BillingOption?#>))
    }

    func didSelectSecondary() {
        selectedSubscriptionInfo = getSecondarySubscriptionInfo()
    }

    private func getMainSubscriptionInfo() -> SubscriptionInfo? {
        parameters.subscriptions.first { $0.isMain } ?? parameters.subscriptions.first
    }

    private func getSecondarySubscriptionInfo() -> SubscriptionInfo? {
        parameters.subscriptions.first { !$0.isMain } ?? parameters.subscriptions.last
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
