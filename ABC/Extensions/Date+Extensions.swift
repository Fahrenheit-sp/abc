//
//  Date+Extensions.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import Foundation

public extension Date {
    func isOneDayPassed(since other: Date) -> Bool {
        let order = Calendar.current.compare(self, to: other, toGranularity: .day)
        return order == .orderedDescending
    }
}
