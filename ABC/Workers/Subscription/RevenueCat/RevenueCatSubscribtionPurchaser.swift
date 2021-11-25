//
//  SubscribtionPurchaser.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Purchases

final class RevenueCatSubscriptionPurchaser {

    private let packages: [Purchases.Package]

    weak var delegate: SubscriptionPurchaserDelegate?

    init(packages: [Purchases.Package]) {
        self.packages = packages
    }

    private func purchase(_ package: Purchases.Package) {
        Purchases.shared.purchasePackage(package) { [weak self] _, info, error, isCancelled in
            guard let self = self else { return }
            if let error = error {
                isCancelled
                    ? self.delegate?.purchaserDidCancelPurchase(self)
                    : self.delegate?.purchaser(self, didFailToPurchaseWith: error)
                return
            }
            guard info?.entitlements[Constants.revenueCatEntitlement]?.isActive == true else { return }
            let expirationDate = info?.expirationDate(forEntitlement: Constants.revenueCatEntitlement)
            self.delegate?.purchaser(self, didSubscribeSuccesfullyUntil: expirationDate)
        }
    }
}

extension RevenueCatSubscriptionPurchaser: SubscriptionPurchaseable {

    func purchase(_ subscriptionInfo: SubscriptionInfo) {
        guard let package = packages.first(where: { subscriptionInfo.priceValue == $0.product.price.doubleValue }) else { return }
        purchase(package)
    }

    func restore() {
        Purchases.shared.restoreTransactions { [weak self] info, error in
            guard let self = self else { return }
            if let error = error {
                self.delegate?.purchaser(self, didFailToPurchaseWith: error)
                return
            }
            guard info?.entitlements[Constants.revenueCatEntitlement]?.isActive == true else {
                self.delegate?.purchaser(self, didFailToPurchaseWith: SubscriptionError.nothingToRestore)
                return
            }
            let expirationDate = info?.expirationDate(forEntitlement: Constants.revenueCatEntitlement)
            self.delegate?.purchaser(self, didRestoreSuccesfullyUntil: expirationDate)
        }
    }
}
