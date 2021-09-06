//
//  Custom.swift
//  ABC
//
//  Created by Игорь Майсюк on 6.09.21.
//

import Foundation

struct Custom: Alphabet {

    let letters: [Letter]
    let numberOfRows: Int
    let numberOfLettersInRow: Int

    func numberOfLetters(in row: Int) -> Int {
        numberOfLettersInRow
    }
}
