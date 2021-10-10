//
//  UserData.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation

struct UserData: Codable {
    let expirationDate: Date?
    var lastListenPlayedDate: Date?
    var lastMemorizePlayedDate: Date?
    var lastMakeAWordPlayedDate: Date?

    func withUpdatedExpirationDate(to date: Date?) -> UserData {
        .init(expirationDate: date,
              lastListenPlayedDate: lastListenPlayedDate,
              lastMemorizePlayedDate: lastMemorizePlayedDate,
              lastMakeAWordPlayedDate: lastMakeAWordPlayedDate)
    }

    var isSubscribed: Bool {
        let currentDate = Date()
        return expirationDate.or(currentDate) > currentDate
    }
}
