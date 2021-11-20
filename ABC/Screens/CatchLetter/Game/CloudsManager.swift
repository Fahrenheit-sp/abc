//
//  CloudsManager.swift
//  AlphabetGame
//
//  Created by Игорь Майсюк on 08.01.18.
//  Copyright © 2018 Fahrenheit. All rights reserved.
//

import SpriteKit

final class CloudsManager {
    private weak var scene: SKScene!
    private let firstCloud: Cloud
    private let secondCloud: Cloud
    private let thirdCloud: Cloud
    private let firstCloudSpeed: CGFloat = 5.0
    private let secondCloudSpeed: CGFloat = 10.0
    private let thirdCloudSpeed: CGFloat = 7.5

    init(with scene: SKScene) {
        self.scene = scene
        firstCloud = Cloud(with: .right, speed: firstCloudSpeed)
        secondCloud = Cloud(with: .left, speed: secondCloudSpeed)
        thirdCloud = Cloud(with: .right, speed: thirdCloudSpeed)
    }

    func beginGenerating() {
        firstCloud.position = CGPoint(x: 0, y: CGFloat.random(in: 0...UIScreen.height/3))
        scene.addChild(firstCloud)
        
        secondCloud.position = CGPoint(x: UIScreen.width / 2.0, y: CGFloat.random(in: (UIScreen.height / 3)...(UIScreen.height / 1.5)))
        scene.addChild(secondCloud)

        thirdCloud.position = CGPoint(x: UIScreen.width, y: CGFloat.random(in: (UIScreen.height / 1.5)...(UIScreen.height)))
        scene.addChild(thirdCloud)
    }

    func update(_ delta: TimeInterval) {
        for cloud in [firstCloud, secondCloud, thirdCloud] {
            cloud.update(delta)
        }
    }
}
