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
    private let player: SoundPlayer
    private let wordsSpeaker: WordsSpeaker
    weak var ui: MakeAWordUserInterface?
    weak var router: MakeAWordRoutable?

    private var words: [Word]
    private var currentWord: Word?
    private var placedLettersCount = 0
    private var finishedWordsCount = 0

    init(parameters: Parameters, ui: MakeAWordUserInterface? = nil, router: MakeAWordRoutable? = nil) {
        self.parameters = parameters
        self.player = SoundPlayer()
        self.ui = ui
        self.router = router
        self.wordsSpeaker = WordsSpeaker()
        self.words = parameters.wordsStorage.getWords()
    }

    func didLoad() {
        ui?.configureCanvas(with: parameters.canvas)
        ui?.configureStarsCount(to: parameters.wordsCount)
        createNewWord(isFirst: true)
    }

    func didPlaceLetter(_ letter: Letter) {
        placedLettersCount += 1
        guard let word = currentWord else { return }
        guard placedLettersCount == word.letters.count else { return player.playLetterPlacedSound() }
        finishWord()
        guard finishedWordsCount < parameters.wordsCount else {
            player.playWinSound()
            ui?.didFinishGame()
            return
        }
        createNewWord()
    }

    func finish() {
        router?.finish()
    }

    private func finishWord() {
        placedLettersCount = 0
        finishedWordsCount += 1
        currentWord.map { wordsSpeaker.speak(word: $0.string) }
        ui?.didFinishWord()
    }

    private func createNewWord(isFirst: Bool = false) {
        if isFirst {
            let shortWords = words.filter { $0.letters.count < 7 }
            currentWord = shortWords.randomElement()
            _ = currentWord.flatMap { words.firstIndex(of: $0) }.flatMap { words.remove(at: $0) }
        } else {
            currentWord = words.remove(at: Int.random(in: 0..<words.count))
        }
        currentWord.map { ui?.configureWord(with: $0) }
    }
}
