//
//  PurchasesFetcher.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation
import Purchases
import StoreKit

final class RevenueCatProductsFetcher: NSObject {

    static let shared = RevenueCatProductsFetcher()
    private var packages: [Purchases.Package] = []

    weak var delegate: ProductsFetcherDelegate?

    private override init() {
        super.init()
        Purchases.shared.delegate = self
    }

    private func subscriptionInfo(for term: Purchases.PackageType) -> SubscriptionInfo {
        guard let package = packages.first(where: { $0.packageType == term }) else { return fallbackSubscriptionInfo(for: term) }
        let trial = package.product.introductoryPrice?.subscriptionPeriod.localizedPeriod()
        let description = subscriptionDescription(for: term)
        let isMain = term == .annual
        return .init(trial: trial, price: package.localizedPriceString, term: package.term, description: description, isMain: isMain)
    }

    private func fallbackSubscriptionInfo(for term: Purchases.PackageType) -> SubscriptionInfo {
        let description = subscriptionDescription(for: term)
        switch term {
        case .annual: return .init(trial: "7 days", price: "29,99 US$", term: L10n.Term.year, description: description, isMain: true)
        case .monthly: return .init(trial: nil, price: "4,99 US$", term: L10n.Term.month, description: description, isMain: false)
        default: return .init(trial: "7 days", price: "29,99 US$", term: L10n.Term.year, description: description, isMain: false)
        }
    }

    private func subscriptionDescription(for term: Purchases.PackageType) -> String {
        switch term {
        case .annual: return L10n.Subscription.perTerm(L10n.Term.year)
        case .monthly: return L10n.Subscription.perTerm(L10n.Term.month)
        default: return L10n.Subscription.perTerm(L10n.Term.year)
        }
    }
}

extension RevenueCatProductsFetcher: ProductsFetchable {
    func fetchProducts() {
        guard packages.isEmpty else {
            delegate?.fetcherDidLoadPurchases(self)
            return
        }
        Purchases.shared.offerings { offerings, error in
            guard let packages = offerings?.current?.availablePackages else { return }
            self.packages = packages
            self.delegate?.fetcherDidLoadPurchases(self)
        }
    }

    func getProductsInfo() -> [SubscriptionInfo] {
        packages.map { subscriptionInfo(for: $0.packageType) }
    }

    func getPurchaser() -> SubscriptionPurchaseable {
        RevenueCatSubscriptionPurchaser(packages: packages)
    }
}

extension RevenueCatProductsFetcher: PurchasesDelegate {
    func purchases(_ purchases: Purchases, didReceiveUpdated purchaserInfo: Purchases.PurchaserInfo) {
        let manager = UserDataManager()
        let expirationDate = purchaserInfo.expirationDate(forEntitlement: Constants.revenueCatEntitlement)
        let user = manager.getUser().withUpdatedExpirationDate(to: expirationDate)
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
