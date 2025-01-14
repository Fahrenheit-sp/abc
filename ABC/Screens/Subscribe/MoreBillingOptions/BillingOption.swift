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
        subscriptionInfo.term.period
    }

    var price: String {
        subscriptionInfo.price.uppercased()
    }

    var subtitle: String {
        subscriptionInfo.description
    }

    var trialText: String? {
        subscriptionInfo.trialDays.map { L10n.Subscription.trialTerm($0) }
    }
}


extension SubscriptionTerm {
    var period: String {
        switch self {
        case .month: return L10n.Term.month
        case .week: return L10n.Term.week
        case .year: return L10n.Term.year
        }
    }
}
