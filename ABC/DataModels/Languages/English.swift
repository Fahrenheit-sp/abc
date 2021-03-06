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

    init(isShuffled: Bool = false) {
        let letters = "abcdefghijklmnopqrstuvwxyz".map { Letter(symbol: $0) }
        self.letters = isShuffled ? letters.shuffled() : letters
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

extension English: Canvas {
    var numberOfCanvasRows: Int {
        3
    }

    func numberOfCanvasLetters(in row: Int) -> Int {
        switch row {
        case 0: return 10
        case 1: return 8
        case 2: return 8
        default: return 0
        }
    }
}

extension English: Memorizable {}
