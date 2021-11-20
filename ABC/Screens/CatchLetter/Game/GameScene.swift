//
//  GameScene.swift
//  AlphabetGame
//
//  Created by Игорь Майсюк on 19.10.17.
//  Copyright © 2017 Fahrenheit. All rights reserved.
//

import SpriteKit

protocol GameSceneDelegate: AnyObject {
    func gameSceneDidIncreaseScore(_ scene: GameScene)
    func gameSceneDidDecreaseScore(_ scene: GameScene)
}

final class GameScene: SKScene {

    private var itemsManager: ItemsManager!
    private var cloudsManager: CloudsManager!
    private var lastUpdateTimeInterval: TimeInterval = 0

    weak var gameDelegate: GameSceneDelegate?

    required init(letter: String, wrongLetters: [String]) {
        super.init(size: UIScreen.main.bounds.size)
        anchorPoint = .zero
        backgroundColor = .background
        itemsManager = ItemsManager(with: letter, wrongLetters: wrongLetters, scene: self) { [weak self] isCorrect in
            guard let self = self else { return }
            isCorrect ? self.gameDelegate?.gameSceneDidIncreaseScore(self) : self.gameDelegate?.gameSceneDidDecreaseScore(self)
        }
        cloudsManager = CloudsManager(with: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        cloudsManager.beginGenerating()
        itemsManager.generate()
    }

    deinit {
        itemsManager.destroy()
    }

    func touchUp(at point: CGPoint) {
        children.compactMap { $0 as? TouchableNode }.first { $0.contains(point) }?.handleTouch()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(at: t.location(in: self)) }
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime
        guard deltaTime < 1.0 else { return }
        itemsManager.update(deltaTime)
        cloudsManager.update(deltaTime)
    }

}
