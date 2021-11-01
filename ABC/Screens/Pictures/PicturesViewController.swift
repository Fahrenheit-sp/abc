//
//  PicturesViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 28.10.21.
//

import UIKit

final class PicturesViewController: UIViewController {
    
    var interactor: PicturesInteractable?

    private let starsView = StarsView().disableAutoresizing()
    private let playButton = UIButton().disableAutoresizing()
    private let imageView = UIImageView().disableAutoresizing()
    private let lineView = LineView().disableAutoresizing()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupInteractions()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background

        view.addSubview(starsView)
        view.addSubview(playButton)
        view.addSubview(imageView)
        view.addSubview(lineView)

        playButton.setImage(Asset.Listen.playButton.image, for: .normal)

        imageView.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            starsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            starsView.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 36 : 54),
            starsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 36),

            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            lineView.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 120 : 200),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                             constant: UIDevice.isiPhone ? -40 : -100),
            lineView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),

        ])
    }

    private func setupInteractions() {
        lineView.delegate = self
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
    }

    @objc private func didTapPlay() {
        interactor?.speakCurrentPicture()
    }
}

extension PicturesViewController: PicturesUserInterface {

    func configureStarsCount(to count: Int) {
        starsView.configure(with: .init(numberOfFilled: 0, numberOfEmpty: count))
    }

    func setPicture(named name: String) {
        imageView.image = UIImage(named: name)
        lineView.setup(word: name)
        UIView.transition(with: imageView, duration: 0.2, options: [.transitionCrossDissolve], animations: nil)
    }

    func didFinishPicture() {
        lineView.clear()
        starsView.increaseFilledCount()
    }

    func didFinishGame() {
        view.isUserInteractionEnabled = false
        let confettiView = ConfettiView()
        view.addSubview(confettiView)

        confettiView.emit(with: [
          .text("🤩"),
          .text("📱"),
          .shape(.circle, .purple),
          .shape(.triangle, .orange),
        ]) { [weak self] _ in
            self?.view.isUserInteractionEnabled = true
            self?.interactor?.finish()
        }
    }
}

extension PicturesViewController: LineViewDelegate {
    func lineView(_ lineView: LineView, didUpdate word: String) {
        interactor?.validate(word: word)
    }

    func lineView(_ lineView: LineView, didPlace letterView: DraggableLetterView) {
        interactor?.playLetterPlacedSound()
    }

    func lineView(_ lineView: LineView, didDelete letterView: DraggableLetterView) {
        interactor?.playLetterRemovedSound()
    }
}
