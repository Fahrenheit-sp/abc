//
//  ItemsManager.swift
//  AlphabetGame
//
//  Created by Игорь Майсюк on 19.10.17.
//  Copyright © 2017 Fahrenheit. All rights reserved.
//

import SpriteKit

final class ItemsManager {

    private let correctLetter: String
    private let wrongLetters: [String]
    private let letterAnimationFinishedAction: (Bool) -> Void
    private var wrongItemsGeneratedCount = 0
    private weak var scene: SKScene?
    private var timer: Timer?
    private let soundPlayer = SoundPlayer()
    private let letterPlayer = LetterSoundPlayer()

    init(with letter: String, wrongLetters: [String], scene: SKScene, letterAnimationFinishedAction: @escaping (Bool) -> Void) {
        self.correctLetter = letter
        self.wrongLetters = wrongLetters
        self.letterAnimationFinishedAction = letterAnimationFinishedAction
        self.scene = scene
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: true) { [weak self] _ in self?.generate() }
    }

    func update(_ interval: TimeInterval) {
        updatePositions(interval: interval)
    }

    func destroy() {
        timer?.invalidate()
        timer = nil
    }

    private func updatePositions(interval: TimeInterval) {
        scene?.children.compactMap { $0 as? TouchableNode }.forEach { $0.changePosition(interval: interval) }
    }

    private func createItem() -> TouchableNode? {
        guard wrongItemsGeneratedCount < 8 else { return generateCorrectLetter() }
        let item = Int.random(in: 0...3)
        switch item {
        case 0: return generateCorrectLetter()
        case 1:
            wrongItemsGeneratedCount += 1
            let rocket = Rocket(imageNamed: "rocket")
            rocket.soundAction = { [weak self] in self?.soundPlayer.playRocketSound() }
            return rocket
        case 2:
            wrongItemsGeneratedCount += 1
            let ufo = Ufo(imageNamed: "ufo")
            ufo.soundAction = { [weak self] in self?.soundPlayer.playUfoSound() }
            return ufo
        default:
            wrongItemsGeneratedCount += 1
            let wrong =  wrongLetters.randomElement()
                .map { SKLetterNode(letter: $0, isCorrect: false, onFinishAnimation: letterAnimationFinishedAction) }
            wrong?.soundAction = { [weak self] in self?.soundPlayer.playErrorSound() }
            return wrong
        }
    }

    private func generateCorrectLetter() -> TouchableNode {
        wrongItemsGeneratedCount = 0
        let correct = SKLetterNode(letter: correctLetter, isCorrect: true, onFinishAnimation: letterAnimationFinishedAction)
        correct.soundAction = { [weak self] in self.map { $0.letterPlayer.playLetterSound(named: $0.correctLetter) } }
        return correct
    }


    @objc func generate() {
        createItem().map {
            $0.position = .init(x: CGFloat.random(in: $0.size.width...UIScreen.width-$0.size.width), y: -$0.size.height)
            scene?.addChild($0)
        }
    }
}
