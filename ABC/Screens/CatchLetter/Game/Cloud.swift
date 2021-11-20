//
//  Cloud.swift
//  AlphabetGame
//
//  Created by Игорь Майсюк on 09.01.18.
//  Copyright © 2018 Fahrenheit. All rights reserved.
//

import SpriteKit

final class Cloud: SKSpriteNode {
    enum Direction {
        case left
        case right
    }

    private var direction: Direction

    init(with direction: Direction, speed: CGFloat) {
        let texture = SKTexture(image: Asset.Games.cloud.image)
        self.direction = direction
        super.init(texture: texture, color: .clear, size: texture.size() / UIScreen.main.scale)
        self.speed = speed
        self.zPosition = 2
    }

    func update(_ delta: TimeInterval) {
        switch direction {
        case .left:
            guard position.x > 0 else { return changeDirection() }
            position.x -= CGFloat(delta * 10 * speed)
        case .right:
            guard position.x < UIScreen.width else { return changeDirection() }
            position.x += CGFloat(delta * 10 * speed)
        }
    }

    private func changeDirection() {
        direction = direction == .left ? .right : .left
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
