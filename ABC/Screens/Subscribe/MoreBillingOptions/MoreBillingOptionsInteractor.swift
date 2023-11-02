//
//  MoreBillingOptionsInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation

final class MoreBillingOptionsInteractor {

    struct Parameters {
        let purchaser: RevenueCatSubscribtionPurchaser
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
        self.selectedSubscriptionInfo = parameters.purchaser.subscriptions.first
    }

    private var description: String {
        guard let current = selectedSubscriptionInfo else { return .empty }
        let price = L10n.Subscription.priceWithoutTrial(current.price, current.term)
        return L10n.Subscription.paymentWithTrialDescription(current.trialDays.or(.empty), price)
    }

}

extension MoreBillingOptionsInteractor: MoreBillingOptionsInteractable {
    func didSelectSubscription(at index: Int) {
        guard index < parameters.purchaser.subscriptions.endIndex else { return }
        self.selectedSubscriptionInfo = parameters.purchaser.subscriptions[index]
        didLoad()
    }

    func didLoad() {
        let options = parameters.purchaser.subscriptions.map { BillingOption(subscriptionInfo: $0, isSelected: $0 == selectedSubscriptionInfo) }
        let model = MoreBillingOptionsViewModel(billingOptions: options, description: description)
        ui?.configure(with: model)
    }

    func didClose() {
        router?.didClose()
    }

    func didPressSubscribe() {
        selectedSubscriptionInfo.map { parameters.purchaser.makePurchase(term: $0.term) }
    }

}

extension MoreBillingOptionsInteractor: SubscriptionPurchaserDelegate {
    func purchaser(didFailToPurchaseWith error: Error) {
        ui?.didFailPurchase(with: error.localizedDescription)
    }

    func purchaser(didSubscribeSuccesfullyUntil date: Date?) {
        let newUser = parameters.userDataManager.getUser().withUpdatedExpirationDate(to: date)
        parameters.userDataManager.save(user: newUser)
    }

    func purchaser(didRestoreSuccesfullyUntil date: Date?) {
        let newUser = parameters.userDataManager.getUser().withUpdatedExpirationDate(to: date)
        parameters.userDataManager.save(user: newUser)
    }

    func purchaserDidCancelPurchase() {
        ui?.didCancelPurchase()
    }
}
