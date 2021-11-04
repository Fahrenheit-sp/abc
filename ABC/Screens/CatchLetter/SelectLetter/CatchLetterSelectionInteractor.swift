//
//  CatchLetterInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import Foundation

final class CatchLetterSelectionInteractor {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    private var currentLetterIndex: Array.Index

    weak var ui: CatchLetterSelectionUserInterface?
    weak var router: CatchLetterSelectionRoutable?

    internal init(parameters: Parameters, ui: CatchLetterSelectionUserInterface? = nil, router: CatchLetterSelectionRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
        self.currentLetterIndex = parameters.alphabet.letters.startIndex
    }

}

extension CatchLetterSelectionInteractor: CatchLetterSelectionInteractable {

    func didLoad() {
        print("Loaded")
    }

    func onLetterSelected() {

    }

    func getNextLetter() -> Letter {
        currentLetterIndex = currentLetterIndex + 1 == parameters.alphabet.letters.endIndex ? 0 : currentLetterIndex + 1
        return parameters.alphabet.letters[currentLetterIndex]
    }

    func getPreviousLetter() -> Letter {
        currentLetterIndex = currentLetterIndex - 1 < 0 ? parameters.alphabet.letters.endIndex - 1 : currentLetterIndex - 1
        return parameters.alphabet.letters[currentLetterIndex]
    }
}
