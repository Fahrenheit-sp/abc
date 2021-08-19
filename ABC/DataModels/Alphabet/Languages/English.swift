//
//  English.swift
//  ABC
//
//  Created by Игорь Майсюк on 20.08.21.
//

import Foundation

struct English: Alphabet {

    let letters: [Letter]
    let numberOfRows = 5

    init() {
        self.letters = "abcdefghijklmnopqrstuvwxyz".map { Letter(symbol: $0) }
    }

    func numberOfLetters(in row: Int) -> Int {
        switch row {
        case 0: return 5
        case 1: return 6
        case 2: return 5
        case 3: return 5
        case 4: return 5
        default: return 0
        }
    }
}
