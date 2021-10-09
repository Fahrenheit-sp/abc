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
    private var purchaser: SubscriptionPurchaseable?
    private let fetcher: ProductsFetchable
    weak var ui: SubscribeUserInterface?
    weak var router: SubscribeRoutable?

    init(ui: SubscribeUserInterface? = nil,
         router: SubscribeRoutable? = nil,
         userDataManager: UserDataManager = .init(),
         fetcher: ProductsFetchable) {
        self.ui = ui
        self.router = router
        self.manager = userDataManager
        self.fetcher = fetcher
        updatePurchaser(from: fetcher)
        fetcher.delegate = self
        fetcher.fetchProducts()
    }
    
    func didLoad() {
        let info = RevenueCatProductsFetcher.shared.mainSubscriptionInfo
        let price = info.trial == nil
            ? L10n.Subscription.priceWithoutTrial(info.price, info.term)
            : L10n.Subscription.priceWithTrial(info.trial!, info.price, info.term)
        ui?.configure(with: .init(priceString: price))
    }

    func didClose() {
        router?.didClose()
    }

    func didRestore() {
        purchaser?.restore()
    }

    func didTapPrivacy() {
        UIApplication.shared.open(Constants.privacyUrl, options: [:], completionHandler: nil)
    }

    func didTapTerms() {
        UIApplication.shared.open(Constants.termsUrl, options: [:], completionHandler: nil)
    }

    func didTapBuyMain() {
        purchaser?.buyYearSubscription()
    }

    func didTapMoreOptions() {
        router?.didTapMoreOptions()
    }

    private func updatePurchaser(from fetcher: ProductsFetchable) {
        purchaser = fetcher.getPurchaser()
        purchaser?.delegate = self
    }
}

extension SubscribeInteractor: ProductsFetcherDelegate {
    func fetcherDidLoadPurchases(_ fetcher: ProductsFetchable) {
        updatePurchaser(from: fetcher)
        DispatchQueue.main.async { self.didLoad() }
    }
}

extension SubscribeInteractor: SubscriptionPurchaserDelegate {
    func purchaser(_ purchaser: SubscriptionPurchaseable, didFailToPurchaseWith error: Error) {
        ui?.didFailPurchase(with: error.localizedDescription)
    }

    func purchaser(_ purchaser: SubscriptionPurchaseable, didSubscribeSuccesfullyUntil date: Date?) {
        let newUser = manager.getUser().withUpdatedExpirationDate(to: date)
        manager.save(user: newUser)
    }

    func purchaser(_ purchaser: SubscriptionPurchaseable, didRestoreSuccesfullyUntil date: Date?) {
        let newUser = manager.getUser().withUpdatedExpirationDate(to: date)
        manager.save(user: newUser)
    }

    func purchaserDidCancelPurchase(_ purchaser: SubscriptionPurchaseable) {
        ui?.didCancelPurchase()
    }
}
