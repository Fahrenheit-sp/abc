//
//  AlphabetViewModel.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import Foundation

struct AlphabetViewViewModel {

    private let alphabet: Alphabet

    var numberOfRows: Int {
        alphabet.numberOfRows
    }

    var isAligned: Bool {
        alphabet.numberOfLetters(in: 0) * alphabet.numberOfRows == alphabet.letters.count
    }

    init(alphabet: Alphabet) {
        self.alphabet = alphabet
    }

    func cellModel(at indexPath: IndexPath, isPlaced: Bool) -> AlphabetCellViewModel {
        let letter = alphabet.letter(at: indexPath)
        return AlphabetCellViewModel(letter: letter, tintColor: isPlaced ? nil : .lightGray)
    }

    func numberOfLetters(in row: Int) -> Int {
        alphabet.numberOfLetters(in: row)
    }

    func letters(in row: Int) -> [Letter] {
        alphabet.letters(in: row)
    }

    func letter(at indexPath: IndexPath) -> Letter {
        alphabet.letter(at: indexPath)
    }

    func indexPath(for letter: Letter) -> IndexPath {
        var section = 0
        for index in (0..<alphabet.numberOfRows) {
            guard alphabet.letters(in: index).contains(letter) else { continue }
            section = index
            break
        }
        guard let row = alphabet.letters(in: section).firstIndex(of: letter) else { return .init(row: 0, section: section) }
        return .init(row: row, section: section)
    }
}
