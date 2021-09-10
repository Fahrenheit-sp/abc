//
//  PurchasesFetcher.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation
import Purchases
import StoreKit

protocol ProductsFetcherDelegate: AnyObject {
    func fetcher(_ fetcher: ProductsFetcher, didFailToPurchaseWith error: Error)
    func fetcherDidCancelPurchase(_ fetcher: ProductsFetcher)
    func fetcherDidSubscribeSuccesfully(_ fetcher: ProductsFetcher, until date: Date?)
    func fetcherDidRestoreSuccesfully(_ fetcher: ProductsFetcher, until date: Date?)
}

final class ProductsFetcher: NSObject {

    private static let entitlementId = "Subscribed"

    static let shared = ProductsFetcher()
    private var packages: [Purchases.Package] = []

    weak var delegate: ProductsFetcherDelegate?

    private var fallbackInfo: SubscriptionInfo {
        .init(trial: "7 days", price: "44,99 US$", term: L10n.Term.year)
    }

    var mainSubscriptionInfo: SubscriptionInfo {
        guard let package = packages.first(where: { $0.packageType == .annual }) else { return fallbackInfo }
        let trial = package.product.introductoryPrice?.subscriptionPeriod.localizedPeriod()
        return SubscriptionInfo(trial: trial, price: package.localizedPriceString, term: package.term)
    }

    private override init() {
        super.init()
        Purchases.shared.delegate = self
    }

    func fetchPurchases() {
        Purchases.shared.offerings { offerings, error in
            guard let packages = offerings?.current?.availablePackages else { return }
            self.packages = packages
        }
    }

    func buyYearSubscription() {
        guard let package = packages.first(where: { $0.packageType == .annual }) else { return }
        purchase(package)
    }

    func buyMonthlySubscription() {
        guard let package = packages.first(where: { $0.packageType == .monthly }) else { return }
        purchase(package)
    }

    func buyWeeklySubscription() {
        guard let package = packages.first(where: { $0.packageType == .weekly }) else { return }
        purchase(package)
    }

    func restorePurchases() {
        Purchases.shared.restoreTransactions { info, error in
            if let error = error {
                self.delegate?.fetcher(self, didFailToPurchaseWith: error)
                return
            }
            guard info?.entitlements[Self.entitlementId]?.isActive == true else {
                self.delegate?.fetcher(self, didFailToPurchaseWith: SubscriptionError.nothingToRestore)
                return
            }
            self.delegate?.fetcherDidRestoreSuccesfully(self, until: info?.expirationDate(forEntitlement: Self.entitlementId))
        }
    }

    private func purchase(_ package: Purchases.Package) {
        Purchases.shared.purchasePackage(package) { _, info, error, isCancelled in
            if let error = error {
                isCancelled
                    ? self.delegate?.fetcherDidCancelPurchase(self)
                    : self.delegate?.fetcher(self, didFailToPurchaseWith: error)
                return
            }
            guard info?.entitlements[Self.entitlementId]?.isActive == true else { return }
            self.delegate?.fetcherDidSubscribeSuccesfully(self, until: info?.expirationDate(forEntitlement: Self.entitlementId))
        }
    }
}

extension ProductsFetcher: PurchasesDelegate {
    func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
        let manager = UserDataManager()
        let user = manager.getUser().withUpdatedExpirationDate(to: purchaserInfo.expirationDate(forEntitlement: Self.entitlementId))
        manager.save(user: user)
    }
}

private extension Purchases.Package {
    var term: String {
        switch packageType {
        case .annual: return L10n.Term.year
        case .monthly: return L10n.Term.month
        case .weekly: return L10n.Term.year
        default: return L10n.Term.year
        }
    }
}

private extension SKProduct.PeriodUnit {
    func toCalendarUnit() -> NSCalendar.Unit {
        switch self {
        case .day:
            return .day
        case .month:
            return .month
        case .week:
            return .weekOfMonth
        case .year:
            return .year
        @unknown default:
            debugPrint("Unknown period unit")
        }
        return .day
    }
}

private extension SKProductSubscriptionPeriod {
    func localizedPeriod() -> String? {
        return PeriodFormatter.format(unit: unit.toCalendarUnit(), numberOfUnits: numberOfUnits)
    }
}

private final class PeriodFormatter {
    static var componentFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.maximumUnitCount = 1
        formatter.unitsStyle = .full
        formatter.zeroFormattingBehavior = .dropAll
        return formatter
    }

    static func format(unit: NSCalendar.Unit, numberOfUnits: Int) -> String? {
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        componentFormatter.allowedUnits = [unit]
        switch unit {
        case .day:
            dateComponents.setValue(numberOfUnits, for: .day)
        case .weekOfMonth:
            let unit: Calendar.Component = numberOfUnits == 1 ? .day : .weekOfMonth
            let number: Int = numberOfUnits == 1 ? 7 : numberOfUnits
            dateComponents.setValue(number, for: unit)
        case .month:
            dateComponents.setValue(numberOfUnits, for: .month)
        case .year:
            dateComponents.setValue(numberOfUnits, for: .year)
        default:
            return nil
        }

        return componentFormatter.string(from: dateComponents)
    }
}
