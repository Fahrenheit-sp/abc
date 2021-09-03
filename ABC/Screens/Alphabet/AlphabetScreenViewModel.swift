//
//  AlphabetScreenViewModel.swift
//  ABC
//
//  Created by Игорь Майсюк on 21.08.21.
//

import UIKit

struct AlphabetScreenViewModel {

    let alphabet: Alphabet
    private let placedLetters: Set<Letter>


    init(alphabet: Alphabet, placedLetters: Set<Letter> = []) {
        self.alphabet = alphabet
        self.placedLetters = placedLetters
    }


    func state(for letter: Letter) -> LetterView.State {
        placedLetters.contains(letter) ? .placed : .gray
    }
}
