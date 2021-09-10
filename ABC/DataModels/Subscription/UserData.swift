//
//  UserData.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation

struct UserData: Codable {
    let isSubscribed: Bool
    let expirationDate: Date?
    var lastListenPlayedDate: Date?
    var lastMemorizePlayedDate: Date?
    var lastMakeAWordPlayedDate: Date?

    func withUpdatedExpirationDate(to date: Date?) -> UserData {
        .init(isSubscribed: date.or(Date()) > Date(),
              expirationDate: date,
              lastListenPlayedDate: lastListenPlayedDate,
              lastMemorizePlayedDate: lastMemorizePlayedDate,
              lastMakeAWordPlayedDate: lastMakeAWordPlayedDate)
    }
}
