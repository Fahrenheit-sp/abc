//
//  AlphabetInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

final class AlphabetInteractor: AlphabetInteractable {

    struct Parameters {
        let alphabet: Alphabet
        let mode: AlphabetMode
    }

    private let parameters: Parameters
    private var placedLetters: Set<Letter> = []

    var ui: AlphabetUserInterface?
    weak var router: AlphabetRoutable?

    internal init(parameters: Parameters, ui: AlphabetUserInterface? = nil, router: AlphabetRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
    }
    
    func didLoad() {
        ui?.configure(with: .init(alphabet: parameters.alphabet))
    }

    func didPlaceLetter(_ letter: Letter) {
        placedLetters.insert(letter)
        ui?.configure(with: .init(alphabet: parameters.alphabet, placedLetters: placedLetters))
    }

    func getNextLetter() -> Letter? {
        parameters.mode == .ordered ? getNextOrderedLetter() : getNextShuffledLetter()
    }

    private func getNextShuffledLetter() -> Letter? {
        Set(parameters.alphabet.letters).subtracting(placedLetters).first
    }

    private func getNextOrderedLetter() -> Letter? {
        parameters.alphabet.letters.first { !placedLetters.contains($0) }
    }
}
