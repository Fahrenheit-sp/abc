//
//  SubscribeInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import class UIKit.UIApplication
import Foundation

final class SubscribeInteractor: SubscribeInteractable {

    private let manager: UserDataManager
    private let purchaser: RevenueCatSubscribtionPurchaser
    weak var ui: SubscribeUserInterface?
    weak var router: SubscribeRoutable?

    init(ui: SubscribeUserInterface? = nil,
         router: SubscribeRoutable? = nil,
         purchaser: RevenueCatSubscribtionPurchaser,
         userDataManager: UserDataManager = .init()) {
        self.ui = ui
        self.router = router
        self.manager = userDataManager
        self.purchaser = purchaser
        purchaser.delegate = self
        purchaser.fetchProducts()
    }
    
    func didLoad() {
        let features = [L10n.Subscription.freeUpdates, L10n.Subscription.noAds, L10n.Subscription.fullAccess]
        guard let info = purchaser.defaultSubscription else { return }
        let price = info.trialDays == nil
        ? L10n.Subscription.priceWithoutTrial(info.price, info.localizedTerm)
        : L10n.Subscription.priceWithTrial(info.trialDays!, info.price, info.localizedTerm)
        ui?.configure(with: .init(priceString: price, features: features))
    }

    func didClose() {
        router?.didClose()
    }

    func didRestore() {
        purchaser.restorePurchase()
    }

    func didTapBuyMain() {
        purchaser.purchaseDefault()
    }

    func didTapMoreOptions() {
        router?.didTapMoreOptions()
    }
}

extension SubscribeInteractor: SubscriptionPurchaserDelegate {
    func purchaser(didFailToPurchaseWith error: Error) {
        ui?.didFailPurchase(with: error.localizedDescription)
    }

    func purchaser(didSubscribeSuccesfullyUntil date: Date?) {
        let newUser = manager.getUser().withUpdatedExpirationDate(to: date)
        manager.save(user: newUser)
    }

    func purchaser( didRestoreSuccesfullyUntil date: Date?) {
        let newUser = manager.getUser().withUpdatedExpirationDate(to: date)
        manager.save(user: newUser)
    }

    func purchaserDidCancelPurchase() {
        ui?.didCancelPurchase()
    }
}
