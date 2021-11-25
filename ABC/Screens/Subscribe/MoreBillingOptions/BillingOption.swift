//
//  BillingOption.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation

struct BillingOption {
    let subscriptionInfo: SubscriptionInfo
    let isSelected: Bool

    init(subscriptionInfo: SubscriptionInfo, isSelected: Bool) {
        self.subscriptionInfo = subscriptionInfo
        self.isSelected = isSelected
    }

    var title: String {
        subscriptionInfo.term.uppercased()
    }

    var price: String {
        subscriptionInfo.price.uppercased()
    }

    var subtitle: String {
        subscriptionInfo.description
    }

    var trialText: String? {
        subscriptionInfo.trial.map { L10n.Subscription.trialTerm($0) }
    }
}
