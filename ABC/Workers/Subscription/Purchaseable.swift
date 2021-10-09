//
//  Purchaseable.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation

protocol SubscriptionPurchaseable: AnyObject {
    var delegate: SubscriptionPurchaserDelegate? { get set }
    func purchase(_ subscriptionInfo: SubscriptionInfo)
    func buyYearSubscription()
    func buyMonthSubscription()
    func buyWeekSubscription()
    func restore()
}

protocol SubscriptionPurchaserDelegate: AnyObject {
    func purchaser(_ purchaser: SubscriptionPurchaseable, didFailToPurchaseWith error: Error)
    func purchaser(_ purchaser: SubscriptionPurchaseable, didSubscribeSuccesfullyUntil date: Date?)
    func purchaser(_ purchaser: SubscriptionPurchaseable, didRestoreSuccesfullyUntil date: Date?)
    func purchaserDidCancelPurchase(_ purchaser: SubscriptionPurchaseable)
}
