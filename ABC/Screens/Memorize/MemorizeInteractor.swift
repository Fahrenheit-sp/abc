//
//  MemorizeInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

private struct Pair {
    var openedLetter: Letter?
    var openedLetterIndexPath: IndexPath?
    var nextLetter: Letter?
    var nexLetterIndexPath: IndexPath?

    var isMatched: Bool {
        guard let opened = openedLetter, let next = nextLetter else { return false }
        return opened == next
    }

    var isFinished: Bool {
        openedLetter != nil && nextLetter != nil
    }

    var indexPaths: [IndexPath] {
        [openedLetterIndexPath, nexLetterIndexPath].compactMap { $0 }
    }

    mutating func openLetter(_ letter: Letter, at indexPath: IndexPath) {
        if openedLetter == nil {
            openedLetter = letter
            openedLetterIndexPath = indexPath
        } else {
            nextLetter = letter
            nexLetterIndexPath = indexPath
        }
    }

    mutating func reset() {
        openedLetter = nil
        openedLetterIndexPath = nil

        nextLetter = nil
        nexLetterIndexPath = nil
    }
}

final class MemorizeInteractor: MemorizeInteractable {

    var ui: MemorizeUserInterface?
    weak var router: MemorizeRoutable?
    private let memorizable: Memorizable & Alphabet
    private var letterPairs: [Letter] = []
    private var pair = Pair()

    private var openedLettersCount = 0 {
        didSet {
            guard openedLettersCount == letterPairs.count else { return }
            router?.didFinishGame()
        }
    }


    internal init(memorizable: Memorizable & Alphabet, ui: MemorizeUserInterface? = nil, router: MemorizeRoutable? = nil) {
        self.memorizable = memorizable
        self.ui = ui
        self.router = router
        self.letterPairs = getLetterPairs(from: memorizable)
    }

    func didLoad() {
        ui?.configure(with: .init(memorizable: memorizable, letters: letterPairs))
    }

    func didOpenLetter(at indexPath: IndexPath) {
        let index = (indexPath.section * memorizable.numberOfMemorizeColumns) + indexPath.row
        let letter = letterPairs[index]
        pair.openLetter(letter, at: indexPath)
        checkIsPairMatched()
    }

    private func checkIsPairMatched() {
        guard pair.isFinished else { return }
        if pair.isMatched {
            ui?.didOpenSameLetters(at: pair.indexPaths)
            openedLettersCount += 2
        } else {
            ui?.didOpenWrongLetters(at: pair.indexPaths)
        }
        pair.reset()
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