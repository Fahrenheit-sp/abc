//
//  AlphabetScreenViewModel.swift
//  ABC
//
//  Created by Игорь Майсюк on 21.08.21.
//

import UIKit

struct AlphabetScreenViewModel {

    private let alphabet: Alphabet
    private let placedLetters: [Letter]

    var numberOfRows: Int {
        alphabet.numberOfRows
    }

    init(alphabet: Alphabet, placedLetters: [Letter] = []) {
        self.alphabet = alphabet
        self.placedLetters = placedLetters
    }

    func numberOfLetters(in row: Int) -> Int {
        alphabet.numberOfLetters(in: row)
    }

    func cellModel(at indexPath: IndexPath) -> AlphabetCellViewModel {
        let letter = alphabet.letter(at: indexPath)
        let isPlaced = placedLetters.contains(letter)
        return AlphabetCellViewModel(image: letter.image, tintColor: isPlaced ? nil : .lightGray)
    }

    func letters(in row: Int) -> [Letter] {
        alphabet.letters(in: row)
    }

    func letter(at indexPath: IndexPath) -> Letter {
        alphabet.letter(at: indexPath)
    }
}