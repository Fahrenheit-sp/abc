//
//  PicturesInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 28.10.21.
//

import Foundation

final class PicturesInteractor {

    struct Parameters {
        let wordsCount: Int = 5
        let picturesStorage: PicturesStorable
        let canvas: Canvas
    }

    private let parameters: Parameters
    private let wordsSpeaker: WordsSpeaker
    private let soundPlayer: SoundPlayer
    weak var ui: PicturesUserInterface?
    weak var router: PicturesRoutable?

    private var pictures: [Picture]
    private var currentPicture: Picture?
    private var correctPicturesCount = 0

    internal init(parameters: Parameters, ui: PicturesUserInterface? = nil, router: PicturesRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
        self.wordsSpeaker = WordsSpeaker()
        self.soundPlayer = SoundPlayer()
        self.pictures = parameters.picturesStorage.getPictures()
    }

    private func selectNewPicture() {
        currentPicture = pictures.randomElement()
        pictures.removeElement(currentPicture)

        currentPicture.map { ui?.setImage(named: $0.title) }
        speakCurrentPicture()
    }
}

extension PicturesInteractor: PicturesInteractable {

    func didLoad() {
        ui?.configureStarsCount(to: parameters.wordsCount)
        ui?.configureCanvas(with: parameters.canvas)
        selectNewPicture()
    }

    func speakCurrentPicture() {
        currentPicture.map { wordsSpeaker.speak(word: $0.title) }
    }

    func playLetterPlacedSound() {
        soundPlayer.playLetterPlacedSound()
    }

    func playLetterRemovedSound() {
        soundPlayer.playSwooshSound()
    }

    func validate(word: String) {
        guard currentPicture?.title == word else { return }
        correctPicturesCount += 1
        ui?.didFinishPicture()
        guard correctPicturesCount == parameters.wordsCount else { return selectNewPicture() }
        soundPlayer.playWinSound()
        ui?.didFinishGame()
    }

    func finish() {
        router?.finish()
    }
}
