//
//  SubscriptionInfo.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation

struct SubscriptionInfo: Hashable, Equatable {
    let trial: String?
    let price: String
    let term: String
    let description: String
    let priceValue: Double
    let isMain: Bool
}
