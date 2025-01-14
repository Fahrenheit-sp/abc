//
//  InAppPurchase.swift
//  InstagramKit
//
//  Created by Игорь Майсюк on 29.04.22.
//

import RevenueCat
import AppsFlyerLib
import class UIKit.UIDevice

enum PurchaseError: String, Error {
    case noProduct = "error.noProductFound"
    case purchaseFailed = "error.purchaseFailed"
    case restoreFailed = "error.failedToRestore"
}

enum SubscriptionTerm {
    case week
    case month
    case year
}

protocol SubscriptionPurchaserDelegate: AnyObject {
    func purchaser(didFailToPurchaseWith error: Error)
    func purchaser(didSubscribeSuccesfullyUntil date: Date?)
    func purchaser(didRestoreSuccesfullyUntil date: Date?)
    func purchaserDidCancelPurchase()
}


final class RevenueCatSubscribtionPurchaser {
    
    private enum DefaultValues {
        static let cancelErrorCode = 2
        static let entitlement = "Subscribed"
    }
    
    weak var delegate: SubscriptionPurchaserDelegate?
    
    private var package: Package?
    private var packages: [Package] = []
    
    var subscriptions: [SubscriptionInfo] {
        packages.map { SubscriptionInfo(trialDays: trialDays(for: $0),
                                        price: $0.localizedPriceString,
                                        term: $0.packageType.term,
                                        description: subscriptionDescription(for: $0.packageType.term),
                                        priceValue: $0.storeProduct.price)
        }
    }
    
    var defaultSubscription: SubscriptionInfo? {
        package.map { SubscriptionInfo(trialDays: trialDays(for: $0),
                                       price: $0.localizedPriceString,
                                       term: $0.packageType.term,
                                       description: subscriptionDescription(for: $0.packageType.term),
                                       priceValue: $0.storeProduct.price)}
    }
    
    func trialDays(for package: Package) -> String? {
        guard let intro = package.storeProduct.introductoryDiscount, intro.paymentMode == .freeTrial else { return nil }
        return intro.subscriptionPeriod.localizedPeriod()
    }
    
    static let shared = RevenueCatSubscribtionPurchaser()
    
    private init() { }
    
    func fetchProducts() {
        Purchases.shared.getOfferings { [weak self] offerings, error in
            self?.packages = offerings?.current?.availablePackages ?? []
            self?.package = offerings?.current?.availablePackages.first
        }
    }
    
    func purchaseDefault() {
        guard let term = package?.packageType.term else { return }
        makePurchase(term: term)
    }
    
    func makePurchase(term: SubscriptionTerm) {
        guard let purchase = packages.first(where: { $0.packageType == term.revenueCatTerm} ) ?? package else {
            delegate?.purchaser(didFailToPurchaseWith: PurchaseError.noProduct)
            return
        }
        Purchases.shared.purchase(package: purchase) { [weak self] _, info, error, isCancelled in
            guard !isCancelled else {
                self?.delegate?.purchaserDidCancelPurchase()
                return
            }
            let expirationDate = info?.expirationDate(forEntitlement: DefaultValues.entitlement)
            if let expirationDate  {
                self?.delegate?.purchaser(didSubscribeSuccesfullyUntil: expirationDate)
            }
            if let error, expirationDate == nil {
                self?.delegate?.purchaser(didFailToPurchaseWith: error)
            }
        }
    }
    
    func validatePurchase() {
        Purchases.shared.getCustomerInfo { [weak self] info, error in
            guard let date = info?.expirationDate(forEntitlement: DefaultValues.entitlement) else { return }
            self?.delegate?.purchaser(didSubscribeSuccesfullyUntil: date)
            let manager = UserDataManager()
            let newUser = manager.getUser().withUpdatedExpirationDate(to: date)
            manager.save(user: newUser)
        }
    }
    
    func restorePurchase() {
        Purchases.shared.restorePurchases { [weak self] info, error in
            guard error == nil else {
                self?.delegate?.purchaser(didFailToPurchaseWith: PurchaseError.restoreFailed)
                return
            }
            guard let date = info?.expirationDate(forEntitlement: DefaultValues.entitlement)
            else {
                self?.delegate?.purchaser(didFailToPurchaseWith: PurchaseError.restoreFailed)
                return
            }
            self?.delegate?.purchaser(didRestoreSuccesfullyUntil: date)
        }
    }
    
    private func subscriptionDescription(for term: SubscriptionTerm) -> String {
        switch term {
        case .year: return L10n.Subscription.perTerm(L10n.Term.year)
        case .month: return L10n.Subscription.perTerm(L10n.Term.month)
        case .week: return L10n.Subscription.perTerm(L10n.Term.week)
        }
    }
    
}

private extension SubscriptionTerm {
    var revenueCatTerm: PackageType {
        switch self {
        case .week: return .weekly
        case .month: return .monthly
        case .year: return .annual
        }
    }
}

private extension PackageType {
    var term: SubscriptionTerm {
        switch self {
        case .weekly: return .week
        case .monthly: return .month
        case .annual: return .year
        default: return .month
        }
    }
}


private extension SubscriptionPeriod {
    func localizedPeriod() -> String? {
        return PeriodFormatter.format(unit: unit.toCalendarUnit(), numberOfUnits: value)
    }
}

private extension SubscriptionPeriod.Unit {
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
