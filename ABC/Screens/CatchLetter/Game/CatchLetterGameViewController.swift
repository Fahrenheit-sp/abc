//
//  CatchLetterSelectionViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import UIKit
import SpriteKit

final class CatchLetterGameViewController: UIViewController {

    var interactor: CatchLetterGameInteractable?

    override func loadView() {
        view = SKView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.didLoad()
    }

}

extension CatchLetterGameViewController: CatchLetterGameUserInterface {

    func configure(with letter: String) {
        guard let view = view as? SKView else { return }
        #warning("Add wrong letters")
        let scene = GameScene(letter: letter, wrongLetters: ["b", "c"])
        scene.scaleMode = .aspectFill
        view.presentScene(scene)
        view.ignoresSiblingOrder = true
        #if DEBUG
        view.showsFPS = true
        view.showsNodeCount = true
        #endif
    }
}
