//
//  SubscriptionInfo.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation

struct SubscriptionInfo: Hashable, Equatable {
    let trialDays: String?
    let price: String
    let term: SubscriptionTerm
    let description: String
    let priceValue: Decimal

    var localizedTerm: String {
        switch term {
        case .week:
            L10n.Term.week
        case .month:
            L10n.Term.month
        case .year:
            L10n.Term.year
        }
    }
}



