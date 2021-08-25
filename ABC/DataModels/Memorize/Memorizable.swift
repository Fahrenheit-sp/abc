//
//  Memorizable.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

protocol Memorizable {
    var numberOfMemorizeRows: Int { get }
    func numberOfCards(in row: Int) -> Int
}

extension Memorizable {

    var numberOfMemorizeRows: Int {
        4
    }

    func numberOfCards(in row: Int) -> Int {
        3
    }
}
