//
//  ListenInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import Foundation

final class ListenInteractor: ListenInteractable {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    weak var router: ListenRoutable?
    weak var ui: ListenUserInterface?

    private let player = LetterSoundPlayer()
    private let soundPlayer = SoundPlayer()
    private var currentLetter: Letter?

    internal init(parameters: ListenInteractor.Parameters, router: ListenRoutable? = nil, ui: ListenUserInterface) {
        self.parameters = parameters
        self.router = router
        self.ui = ui
    }

    func didLoad() {
        ui?.configure(with: .init(alphabet: parameters.alphabet))
    }

    func didPressPlay() {
        if currentLetter == nil {
            currentLetter = getNextLetter()
            ui?.configure(with: .init(alphabet: getRandomElementsExcept(currentLetter)))
        }
        playCurrentLetterSound()
    }

    func didSelect(letter: Letter) {
        guard let current = currentLetter else { return }
        guard letter == current else { return performWrongLetterActions(for: letter) }
        performRightLetterActions(for: letter)
    }

    private func performRightLetterActions(for letter: Letter) {
        currentLetter = getNextLetter()
        ui?.configure(with: .init(alphabet: getRandomElementsExcept(currentLetter)))
        playCurrentLetterSound()
    }

    private func performWrongLetterActions(for letter: Letter) {
        soundPlayer.playErrorSound()
        ui?.handleWrongSelection(of: letter)
    }

    private func getNextLetter() -> Letter? {
        var next = parameters.alphabet.letters.randomElement()
        guard currentLetter != nil else { return next }
        while currentLetter == next {
            next = parameters.alphabet.letters.randomElement()
        }
        return next
    }

    private func playCurrentLetterSound() {
        currentLetter.map { player.playLetterSound(named: String($0.symbol)) }
    }

    private func getRandomElementsExcept(_ element: Letter?, count: Int = 5) -> Alphabet {
        guard let letter = element, count < parameters.alphabet.letters.count else { return parameters.alphabet }
        var letters: Set<Letter> = [letter]
        while letters.count < count + 1 {
            _ = parameters.alphabet.letters.randomElement().map { letters.insert($0) }
        }
        return Custom(letters: Array(letters), numberOfRows: 3, numberOfLettersInRow: 2)
    }
}
