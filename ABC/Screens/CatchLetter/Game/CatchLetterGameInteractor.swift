//
//  CatchLetterInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import Foundation

final class CatchLetterGameInteractor {

    struct Parameters {
        let alphabet: Alphabet
        let letter: Letter
    }

    private let parameters: Parameters
    private var currentLetterIndex: Array.Index

    weak var ui: CatchLetterGameUserInterface?
    weak var router: CatchLetterGameRoutable?

    internal init(parameters: Parameters, ui: CatchLetterGameUserInterface? = nil, router: CatchLetterGameRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
        self.currentLetterIndex = parameters.alphabet.letters.startIndex
    }

}

extension CatchLetterGameInteractor: CatchLetterGameInteractable {

    func didLoad() {
        ui?.configure(with: String(parameters.letter.symbol))
    }
}
