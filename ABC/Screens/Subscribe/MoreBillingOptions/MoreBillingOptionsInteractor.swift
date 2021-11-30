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
        let userDataManager: UserDataManager = .init()
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
        self.selectedSubscriptionInfo = parameters.subscriptions.first { $0.isMain } ?? parameters.subscriptions.first
    }

    private var description: String {
        guard let current = selectedSubscriptionInfo else { return .empty }
        let price = L10n.Subscription.priceWithoutTrial(current.price, current.term)
        return L10n.Subscription.paymentWithTrialDescription(current.trial.or(.empty), price)
    }

}

extension MoreBillingOptionsInteractor: MoreBillingOptionsInteractable {
    func didSelectSubscription(at index: Int) {
        guard index < parameters.subscriptions.endIndex else { return }
        self.selectedSubscriptionInfo = parameters.subscriptions[index]
        didLoad()
    }

    func didLoad() {
        let options = parameters.subscriptions.map { BillingOption(subscriptionInfo: $0, isSelected: $0 == selectedSubscriptionInfo) }
        let model = MoreBillingOptionsViewModel(billingOptions: options, description: description)
        ui?.configure(with: model)
    }

    func didClose() {
        router?.didClose()
    }

    func didPressSubscribe() {
        selectedSubscriptionInfo.map { parameters.purchaser.purchase($0) }
    }

}

extension MoreBillingOptionsInteractor: SubscriptionPurchaserDelegate {
    func purchaser(_ purchaser: SubscriptionPurchaseable, didFailToPurchaseWith error: Error) {
        ui?.didFailPurchase(with: error.localizedDescription)
    }

    func purchaser(_ purchaser: SubscriptionPurchaseable, didSubscribeSuccesfullyUntil date: Date?) {
        let newUser = parameters.userDataManager.getUser().withUpdatedExpirationDate(to: date)
        parameters.userDataManager.save(user: newUser)
    }

    func purchaser(_ purchaser: SubscriptionPurchaseable, didRestoreSuccesfullyUntil date: Date?) {
        let newUser = parameters.userDataManager.getUser().withUpdatedExpirationDate(to: date)
        parameters.userDataManager.save(user: newUser)
    }

    func purchaserDidCancelPurchase(_ purchaser: SubscriptionPurchaseable) {
        ui?.didCancelPurchase()
    }
}
