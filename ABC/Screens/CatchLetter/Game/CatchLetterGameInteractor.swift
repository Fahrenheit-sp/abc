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
        let goalScore = 5
    }

    private let parameters: Parameters
    private var score: Int
    private let soundPlayer = SoundPlayer()

    weak var ui: CatchLetterGameUserInterface?
    weak var router: CatchLetterGameRoutable?

    internal init(parameters: Parameters, ui: CatchLetterGameUserInterface? = nil, router: CatchLetterGameRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
        score = 0
    }

}

extension CatchLetterGameInteractor: CatchLetterGameInteractable {

    func didLoad() {
        ui?.configure(with: String(parameters.letter.symbol),
                      wrongLetters: parameters.alphabet.letters.filter { $0 != parameters.letter}.map { String($0.symbol) },
                      score: parameters.goalScore)
    }

    func didTapCorrectLetter() {
        score += 1
        ui?.increaseStarsCount()
        guard score == parameters.goalScore else { return }
        soundPlayer.playWinSound()
        ui?.onGameFinished()
    }

    func didTapWrongLetter() {
        score = max(0, score-1)
        ui?.decreaseStarsCount()
    }

    func finish() {
        router?.didFinishGame()
    }
}
