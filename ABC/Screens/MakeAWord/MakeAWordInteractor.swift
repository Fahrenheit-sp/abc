//
//  MakeAWordInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import Foundation

final class MakeAWordInteractor: MakeAWordInteractable {

    struct Parameters {
        let wordsStorage: WordsStorable
        let wordsCount: Int = 5
        let canvas: Canvas
    }

    private let parameters: Parameters
    weak var ui: MakeAWordUserInterface?
    weak var router: MakeAWordRoutable?

    private var words: [Word]
    private var currentWord: Word?
    private var placedLettersCount = 0
    private var finishedWordsCount = 0

    init(parameters: Parameters, ui: MakeAWordUserInterface? = nil, router: MakeAWordRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
        self.words = parameters.wordsStorage.getWords()
    }

    func didLoad() {
        ui?.configureCanvas(with: parameters.canvas)
        ui?.configureStarsCount(to: parameters.wordsCount)
        createNewWord()
    }

    func didPlaceLetter(_ letter: Letter) {
        placedLettersCount += 1
        guard let word = currentWord else { return }
        guard placedLettersCount == word.letters.count else { return }
        finishWord()
        guard finishedWordsCount < parameters.wordsCount else {
            ui?.didFinishGame()
            return
        }
        createNewWord()
    }

    private func finishWord() {
        placedLettersCount = 0
        finishedWordsCount += 1
        ui?.didFinishWord()
    }

    private func createNewWord() {
        currentWord = words.remove(at: Int.random(in: 0..<words.count))
        currentWord.map { ui?.configureWord(with: $0) }
    }
}
