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
        self.selectedSubscriptionInfo = getMainSubscriptionInfo()
    }

    private func getMainSubscriptionInfo() -> SubscriptionInfo? {
        parameters.subscriptions.first { $0.isMain } ?? parameters.subscriptions.first
    }

    private func getSecondarySubscriptionInfo() -> SubscriptionInfo? {
        parameters.subscriptions.first { !$0.isMain } ?? parameters.subscriptions.last
    }

    private func mainDescription() -> String {
        let main = getMainSubscriptionInfo()
        let price = L10n.Subscription.priceWithoutTrial(main?.price ?? "39,99 US$", main?.term ?? L10n.Term.year)
        return L10n.Subscription.paymentWithTrialDescription(main?.trial ?? "7 days", price)
    }

    private func secondaryDescription() -> String {
        let secondary = getSecondarySubscriptionInfo()
        let price = L10n.Subscription.priceWithoutTrial(secondary?.price ?? "4,99 US$", secondary?.term ?? L10n.Term.month)
        return L10n.Subscription.paymentWithoutTrialDescription(price)
    }
}

extension MoreBillingOptionsInteractor: MoreBillingOptionsInteractable {
    func didLoad() {
        let main = getMainSubscriptionInfo()
        let secondary = getSecondarySubscriptionInfo()
        ui?.configure(with: .init(mainBillingOption: .init(subscriptionInfo: main, isSelected: true),
                                  secondaryBillingOption: .init(subscriptionInfo: secondary, isSelected: false),
                                  description: mainDescription()))
    }

    func didClose() {
        router?.didClose()
    }

    func didSelectMain() {
        let main = getMainSubscriptionInfo()
        let secondary = getSecondarySubscriptionInfo()
        selectedSubscriptionInfo = main
        ui?.configure(with: .init(mainBillingOption: .init(subscriptionInfo: main, isSelected: true),
                                  secondaryBillingOption: .init(subscriptionInfo: secondary, isSelected: false),
                                  description: mainDescription()))
    }

    func didSelectSecondary() {
        let main = getMainSubscriptionInfo()
        let secondary = getSecondarySubscriptionInfo()
        selectedSubscriptionInfo = secondary
        ui?.configure(with: .init(mainBillingOption: .init(subscriptionInfo: main, isSelected: false),
                                  secondaryBillingOption: .init(subscriptionInfo: secondary, isSelected: true),
                                  description: secondaryDescription()))
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
