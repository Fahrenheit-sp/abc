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
    var ui: ListenUserInterface

    private let player = SoundPlayer()
    private var currentLetter: Letter?

    internal init(parameters: ListenInteractor.Parameters, router: ListenRoutable? = nil, ui: ListenUserInterface) {
        self.parameters = parameters
        self.router = router
        self.ui = ui
    }

    func didLoad() {
        ui.configure(with: .init(alphabet: parameters.alphabet))
    }

    func didPressPlay() {
        if currentLetter == nil {
            currentLetter = getNextLetter()
        }
        playCurrentLetterSound()
    }

    func didSelect(letter: Letter) {
        guard let current = currentLetter else { return }
        guard letter == current else { return ui.handleWrongSelection(of: letter) }
        ui.handleRightSelection(of: letter)

        currentLetter = getNextLetter()
        playCurrentLetterSound()
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
}
