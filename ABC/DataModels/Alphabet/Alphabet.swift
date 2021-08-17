//
//  Alphabet.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

protocol Alphabet {
    var letters: [Letter] { get }
    var numberOfRows: Int { get }
    func numberOfLetters(in row: Int) -> Int
    func letter(at indexPath: IndexPath) -> Letter
}

struct English: Alphabet {

    let letters: [Letter]
    let numberOfRows = 5

    init() {
        self.letters = "abcdefghijklmnopqrstuvwxyz".map { Letter(symbol: $0) }
    }

    func numberOfLetters(in row: Int) -> Int {
        switch row {
        case 0: return 6
        case 1: return 6
        case 2: return 5
        case 3: return 5
        case 4: return 4
        default: return 0
        }
    }

    func letter(at indexPath: IndexPath) -> Letter {
        guard indexPath.section > 0 else { return letters[indexPath.item] }
        let index = (0 ..< indexPath.section).reduce(0) { $0 + numberOfLetters(in: $1) } + indexPath.item
        guard index < letters.endIndex else { return Letter(symbol: "a") }
        return letters[index]
    }
}
