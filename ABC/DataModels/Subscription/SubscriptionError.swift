//
//  SubscriptionError.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation

enum SubscriptionError: LocalizedError {
    case nothingToRestore

    var errorDescription: String? {
        switch self {
        case .nothingToRestore: return L10n.Error.nothingToRestore
        }
    }
}
