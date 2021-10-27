//
//  Array.swift
//  ABC
//
//  Created by Игорь Майсюк on 27.10.21.
//

import Foundation

extension Array where Element: Equatable {

    @discardableResult
    mutating func removeElement(_ element: Element?) -> Element? {
        guard let element = element else { return nil }
        guard let index = self.firstIndex(of: element) else { return nil }
        return self.remove(at: index)
    }
}
