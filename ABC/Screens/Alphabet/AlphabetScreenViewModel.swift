//
//  AlphabetScreenViewModel.swift
//  ABC
//
//  Created by Игорь Майсюк on 21.08.21.
//

import UIKit

struct AlphabetScreenViewModel {

    private let alphabet: Alphabet
    private let mode: AlphabetMode
    private let placedLetters: Set<Letter>

    var numberOfRows: Int {
        alphabet.numberOfRows
    }

    init(alphabet: Alphabet, placedLetters: Set<Letter> = [], mode: AlphabetMode = .ordered) {
        self.alphabet = alphabet
        self.placedLetters = placedLetters
        self.mode = mode
    }

    func numberOfLetters(in row: Int) -> Int {
        alphabet.numberOfLetters(in: row)
    }

    func cellModel(at indexPath: IndexPath) -> AlphabetCellViewModel {
        let letter = alphabet.letter(at: indexPath)
        let isPlaced = placedLetters.contains(letter)
        return AlphabetCellViewModel(image: letter.image, tintColor: isPlaced ? nil : .lightGray)
    }

    func nextLetter() -> Letter? {
        mode == .ordered ? getNextOrderedLetter() : getNextShuffledLetter()
    }

    func letters(in row: Int) -> [Letter] {
        alphabet.letters(in: row)
    }

    func letter(at indexPath: IndexPath) -> Letter {
        alphabet.letter(at: indexPath)
    }

    private func getNextShuffledLetter() -> Letter? {
        Set(alphabet.letters).subtracting(placedLetters).first
    }

    private func getNextOrderedLetter() -> Letter? {
        alphabet.letters.first { !placedLetters.contains($0) }
    }
}
