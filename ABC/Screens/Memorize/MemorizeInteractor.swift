//
//  MemorizeInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

final class MemorizeInteractor: MemorizeInteractable {

    var ui: MemorizeUserInterface?
    weak var router: MemorizeRoutable?
    private let memorizable: Memorizable & Alphabet
    private var letterPairs: [Letter] = []

    internal init(memorizable: Memorizable & Alphabet, ui: MemorizeUserInterface? = nil, router: MemorizeRoutable? = nil) {
        self.memorizable = memorizable
        self.ui = ui
        self.router = router
        self.letterPairs = getLetterPairs(from: memorizable)
    }

    func didLoad() {
        ui?.configure(with: .init(memorizable: memorizable, letters: letterPairs))
    }

    private func getLetterPairs(from memo: Memorizable & Alphabet) -> [Letter] {
        let numberOfLetters = (memo.numberOfMemorizeRows * memo.numberOfMemorizeColumns) / 2
        guard memo.letters.count > numberOfLetters else { return [] }
        var randomLetters: Set<Letter> = []
        while randomLetters.count < numberOfLetters {
            guard let random = memo.letters.randomElement() else { continue }
            randomLetters.insert(random)
        }
        return (Array(randomLetters) + Array(randomLetters)).shuffled()
    }
}
