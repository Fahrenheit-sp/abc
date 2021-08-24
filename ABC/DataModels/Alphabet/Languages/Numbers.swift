//
//  Numbers.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import Foundation

struct Numbers: Alphabet {

    let letters: [Letter]
    let numberOfRows = 4

    init(isShuffled: Bool = false) {
        let letters = "1234567890".map { Letter(symbol: $0) }
        self.letters = isShuffled ? letters.shuffled() : letters
    }

    func numberOfLetters(in row: Int) -> Int {
        switch row {
        case 0: return 3
        case 1: return 3
        case 2: return 3
        case 3: return 1
        default: return 0
        }
    }
}

extension Numbers: Canvas {
    var numberOfCanvasRows: Int {
        1
    }

    func numberOfCanvasLetters(in row: Int) -> Int {
        10
    }
}
