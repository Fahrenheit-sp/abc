//
//  SubscriptionError.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation

enum SubscriptionError: LocalizedError {
    case nothingToRestore
    case productNotFound

    var errorDescription: String? {
        switch self {
        case .nothingToRestore: return L10n.Error.nothingToRestore
        case .productNotFound: return L10n.Error.productNotFound
        }
    }
}
