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
            return Rocket(imageNamed: "rocket")
        case 2:
            wrongItemsGeneratedCount += 1
            return Ufo(imageNamed: "ufo")
        default:
            wrongItemsGeneratedCount += 1
            return wrongLetters.randomElement().map { SKLetterNode(letter: $0, isCorrect: false, onFinishAnimation: letterAnimationFinishedAction) }
        }
    }

    private func generateCorrectLetter() -> TouchableNode {
        wrongItemsGeneratedCount = 0
        return SKLetterNode(letter: correctLetter, isCorrect: true, onFinishAnimation: letterAnimationFinishedAction)
    }


    @objc func generate() {
        createItem().map {
            $0.position = .init(x: CGFloat.random(in: $0.size.width...UIScreen.width-$0.size.width), y: -$0.size.height)
            scene?.addChild($0)
        }
    }
}
