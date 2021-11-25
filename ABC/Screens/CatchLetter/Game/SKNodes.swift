//
//  SKNodes.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import SpriteKit

protocol TouchableNode: SKSpriteNode {
    func handleTouch()
}

extension TouchableNode {
    func changePosition(interval: TimeInterval) {
        self.position.y += CGFloat(interval * 150 * 2)
        guard self.position.y > UIScreen.height + size.height / 2 else { return }
        self.removeFromParent()
    }
}

final class SKLetterNode: SKSpriteNode, TouchableNode {

    let isCorrect: Bool
    let onFinishAnimation: (Bool) -> Void
    var soundAction: (() -> Void)?

    init(letter: String, isCorrect: Bool, onFinishAnimation: @escaping (Bool) -> Void) {
        self.isCorrect = isCorrect
        self.onFinishAnimation = onFinishAnimation
        let texture = SKTexture(imageNamed: letter)
        super.init(texture: texture, color: .clear, size: texture.size())
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func handleTouch() {
        isCorrect ? handleRightTap() : handleWrongTap()
    }

    private func handleWrongTap() {
        let x: CGFloat = position.x > UIScreen.width / 2 ? UIScreen.width + size.width : -size.width
        let move = SKAction.moveTo(x: x, duration: 1)
        let rotate = SKAction.rotate(byAngle: .pi, duration: 1)
        let playSound = SKAction.run { self.soundAction?() }
        let group = SKAction.group([move, rotate, playSound])
        let notify = SKAction.run { self.onFinishAnimation(false) }
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([group, notify, remove])
        run(sequence)
    }

    private func handleRightTap() {
        texture = SKTexture(image: Asset.Games.starFilled.image)
        size = texture!.size()
        let blurStar = SKSpriteNode(imageNamed: Asset.Games.starEmpty.name)
        let scale = SKAction.scale(to: 3.0, duration: 0.25)
        let fadeOut = SKAction.fadeOut(withDuration: 0.7)
        let blurAction = SKAction.group([scale, fadeOut])
        addChild(blurStar)
        blurStar.run(blurAction)
        let point = CGPoint(x: UIScreen.width / 2, y: UIScreen.height - 100)
        let move = SKAction.move(to: point, duration: 1.0)
        let playSound = SKAction.run { self.soundAction?() }
        let dismiss = SKAction.fadeOut(withDuration: 0.25)
        let notify = SKAction.run { self.onFinishAnimation(true) }
        let group = SKAction.sequence([playSound, move, notify, dismiss])
        run(group)
    }
}

final class Obstacle: SKSpriteNode, TouchableNode {

    var soundAction: (() -> Void)?

    func handleTouch() {
        let point = CGPoint(x: position.x, y: UIScreen.height)
        let move = SKAction.move(to: point, duration: 0.7)
        let playSound = SKAction.run { self.soundAction?() }
        let sequence = SKAction.group([move, playSound])
        run(sequence)
    }

}
