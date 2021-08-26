//
//  Word.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import Foundation

struct Word {

    let string: String
    let letters: [Letter]

    init(string: String) {
        self.string = string
        self.letters = string.map { Letter(symbol: $0) }
    }
}
