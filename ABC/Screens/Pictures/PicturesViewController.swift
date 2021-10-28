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
    private let lineView = UIView().disableAutoresizing()
    private let canvasView = CanvasAlphabetView().disableAutoresizing()

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
        view.addSubview(canvasView)

        playButton.setImage(Asset.Listen.playButton.image, for: .normal)

        imageView.contentMode = .scaleAspectFit

        lineView.backgroundColor = .lightGray
        lineView.roundCorners(to: 1)

        NSLayoutConstraint.activate([
            starsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            starsView.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 36 : 54),
            starsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 36),

            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            imageView.topAnchor.constraint(equalTo: starsView.bottomAnchor, constant: 24),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -120),

            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lineView.bottomAnchor.constraint(equalTo: canvasView.topAnchor, constant: -40),
            lineView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),

            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),
        ])
    }

    private func setupInteractions() {
        canvasView.delegate = self
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
    }

    @objc private func didTapPlay() {
        print("Play sound")
    }
}

extension PicturesViewController: PicturesUserInterface {

    func configureStarsCount(to count: Int) {
        starsView.configure(with: .init(numberOfFilled: 0, numberOfEmpty: count))
    }

    func setImage(named name: String) {
        imageView.image = UIImage(named: name)
    }

    func configureCanvas(with canvas: Canvas) {
        canvasView.configure(with: .init(canvas: canvas))
    }
}

extension PicturesViewController: CanvasAlphabetViewDelegate {
    func canvasView(_ canvasView: CanvasAlphabetView, didEndDragging letterView: DraggableLetterView, at point: CGPoint) {
        let newLetter = DeletableLetterView(letter: letterView.letter)
        newLetter.frame = CGRect(origin: .zero, size: letterView.frame.size)
        newLetter.center = point
        view.addSubview(newLetter)

        UIView.animate(withDuration: 0.2) {
            newLetter.transform = .init(scaleX: 1.75, y: 1.75)
        }

        letterView.resetWithScale()
    }
}
