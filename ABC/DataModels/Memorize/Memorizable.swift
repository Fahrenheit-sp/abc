//
//  Memorizable.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

protocol Memorizable {
    var numberOfMemorizeRows: Int { get }
    var numberOfMemorizeColumns: Int { get }
}

extension Memorizable {

    var numberOfMemorizeRows: Int {
        4
    }

    var numberOfMemorizeColumns: Int {
        3
    }
}
