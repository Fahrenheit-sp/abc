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
    private var wrongItemsGeneratedCount = 0
    private weak var scene: SKScene?
    private var timer: Timer?

    init(with letter: String, wrongLetters: [String], scene: SKScene) {
        self.correctLetter = letter
        self.wrongLetters = wrongLetters
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
        guard wrongItemsGeneratedCount < 7 else {
            wrongItemsGeneratedCount = 0
            return SKLetterNode(letter: correctLetter, isCorrect: true)
        }
        let item = Int.random(in: 0...3)
        switch item {
        case 0:
            wrongItemsGeneratedCount = 0
            return SKLetterNode(letter: correctLetter, isCorrect: true)
        case 1:
            wrongItemsGeneratedCount += 1
            return Rocket(imageNamed: "rocket")
        case 2:
            wrongItemsGeneratedCount += 1
            return Ufo(imageNamed: "ufo")
        default:
            wrongItemsGeneratedCount += 1
            return wrongLetters.randomElement().map { SKLetterNode(letter: $0, isCorrect: false) }
        }
    }


    @objc func generate() {
        createItem().map {
            $0.position = .init(x: CGFloat.random(in: $0.size.width...UIScreen.width-$0.size.width), y: -$0.size.height)
            scene?.addChild($0)
        }
    }
}
