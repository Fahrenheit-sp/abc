//
//  CatchLetterSelectionViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import UIKit
import SpriteKit

final class CatchLetterGameViewController: UIViewController {

    private let starsView = StarsView().disableAutoresizing()
    private var scene: GameScene?

    var interactor: CatchLetterGameInteractable?

    override func loadView() {
        view = SKView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.didLoad()

        setupUI()
    }

    private func setupUI() {
        view.addSubview(starsView)

        NSLayoutConstraint.activate([
            starsView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            starsView.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 36 : 54),
            starsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }

}

extension CatchLetterGameViewController: CatchLetterGameUserInterface {

    func configure(with letter: String, wrongLetters: [String], score: Int) {
        starsView.configure(with: .init(numberOfFilled: 0, numberOfEmpty: score))
        guard let view = view as? SKView else { return }
        let scene = GameScene(letter: letter, wrongLetters: wrongLetters)
        scene.scaleMode = .aspectFill
        scene.gameDelegate = self
        view.presentScene(scene)
        view.ignoresSiblingOrder = true

        self.scene = scene
    }

    func increaseStarsCount() {
        starsView.increaseFilledCount()
    }

    func decreaseStarsCount() {
        starsView.decreaseFilledCount()
    }
}

extension CatchLetterGameViewController: GameSceneDelegate {
    func gameSceneDidIncreaseScore(_ scene: GameScene) {
        interactor?.didTapCorrectLetter()
    }

    func gameSceneDidDecreaseScore(_ scene: GameScene) {
        interactor?.didTapWrongLetter()
    }

    func onGameFinished() {
        scene?.isPaused = true
        let confettiView = ConfettiView()
        view.addSubview(confettiView)

        confettiView.emit(with: [
          .text("🤩"),
          .text("📱"),
          .shape(.circle, .purple),
          .shape(.triangle, .orange),
        ]) { [weak self] _ in self?.interactor?.finish() }
    }
}
