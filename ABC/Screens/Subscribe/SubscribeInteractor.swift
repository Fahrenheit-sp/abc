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
    weak var ui: SubscribeUserInterface?
    weak var router: SubscribeRoutable?

    init(ui: SubscribeUserInterface? = nil, router: SubscribeRoutable? = nil) {
        self.ui = ui
        self.router = router
        self.manager = UserDataManager()
        ProductsFetcher.shared.delegate = self
        ProductsFetcher.shared.fetchPurchases()
    }
    
    func didLoad() {
        let info = ProductsFetcher.shared.mainSubscriptionInfo
        let price = info.trial == nil
            ? L10n.Subscription.priceWithoutTrial(info.price, info.term)
            : L10n.Subscription.priceWithTrial(info.trial!, info.price, info.term)
        ui?.configure(with: .init(priceString: price))
    }

    func didClose() {
        router?.didClose()
    }

    func didRestore() {
        ProductsFetcher.shared.restorePurchases()
    }

    func didTapPrivacy() {
        UIApplication.shared.open(Constants.privacyUrl, options: [:], completionHandler: nil)
    }

    func didTapTerms() {
        UIApplication.shared.open(Constants.termsUrl, options: [:], completionHandler: nil)
    }

    func didTapBuyMain() {
        ProductsFetcher.shared.buyYearSubscription()
    }
}

extension SubscribeInteractor: ProductsFetcherDelegate {

    func fetcherDidLoadPurchases(_ fetcher: ProductsFetcher) {
        DispatchQueue.main.async { self.didLoad() }
    }

    func fetcher(_ fetcher: ProductsFetcher, didFailToPurchaseWith error: Error) {
        ui?.didFailPurchase(with: error.localizedDescription)
    }

    func fetcherDidCancelPurchase(_ fetcher: ProductsFetcher) {
        ui?.didCancelPurchase()
    }

    func fetcherDidSubscribeSuccesfully(_ fetcher: ProductsFetcher, until date: Date?) {
        let newUser = manager.getUser().withUpdatedExpirationDate(to: date)
        manager.save(user: newUser)
    }

    func fetcherDidRestoreSuccesfully(_ fetcher: ProductsFetcher, until date: Date?) {
        let newUser = manager.getUser().withUpdatedExpirationDate(to: date)
        manager.save(user: newUser)
    }
}
