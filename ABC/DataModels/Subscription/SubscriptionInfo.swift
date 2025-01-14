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
}



