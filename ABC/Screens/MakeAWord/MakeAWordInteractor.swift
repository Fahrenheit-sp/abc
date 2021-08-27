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
        let canvas: Canvas
    }

    private let parameters: Parameters
    var ui: MakeAWordUserInterface?
    weak var router: MakeAWordRoutable?
    private var words: [Word]
    var currentWord: Word?
    var placedLetters: [Letter] = []

    init(parameters: Parameters, ui: MakeAWordUserInterface? = nil, router: MakeAWordRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
        self.words = parameters.wordsStorage.getWords()
    }

    func didLoad() {
        ui?.configureCanvas(with: parameters.canvas)
        createNewWord()
    }

    func didPlaceLetter(_ letter: Letter) {
        placedLetters.append(letter)
        guard let word = currentWord else { return }
        guard placedLetters.count == word.letters.count else { return }
        placedLetters.removeAll()
        ui?.didFinishWord()
        createNewWord()
    }

    private func createNewWord() {
        currentWord = words.remove(at: Int.random(in: 0..<words.count))
        currentWord.map { ui?.configureWord(with: $0) }
    }
}
