//
//  MakeAWordViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class MakeAWordViewController: UIViewController {

    var interactor: MakeAWordInteractable?

    private let starsView = StarsView().disableAutoresizing()
    private let canvasView = CanvasAlphabetView().disableAutoresizing()
    private let wordView = WordView().disableAutoresizing()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(starsView)
        view.addSubview(wordView)
        view.addSubview(canvasView)

        canvasView.delegate = self

        NSLayoutConstraint.activate([
            starsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            starsView.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 36 : 54),
            starsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),

            wordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            wordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            wordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
          //  wordView.heightAnchor.constraint(equalToConstant: UIDevice.isiPhone ? 100 : 250)
        ])
    }

}

extension MakeAWordViewController: MakeAWordUserInterface {
    func configureStarsCount(to count: Int) {
        starsView.configure(with: .init(numberOfFilled: 0, numberOfEmpty: count))
    }

    func configureCanvas(with canvas: Canvas) {
        canvasView.configure(with: .init(canvas: canvas))
    }

    func configureWord(with word: Word) {
        wordView.setWord(to: word)
    }

    func didFinishWord() {
        starsView.increaseFilledCount()
    }

    func didFinishGame() {
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

extension MakeAWordViewController: CanvasAlphabetViewDelegate {
    func canvasView(_ canvasView: CanvasAlphabetView, didEndDragging letterView: DraggableLetterView, at point: CGPoint) {
        guard let overLetterView = wordView.letterView(at: point), !overLetterView.isPlaced else { return letterView.reset() }
        guard letterView.letter == overLetterView.letter else { return letterView.reset() }
        place(letterView, to: overLetterView, from: point)
    }

    private func place(_ letterView: DraggableLetterView, to targetView: LetterView, from point: CGPoint) {
        guard let letter = letterView.letter else { return }
        let newView = LetterView(frame: .init(origin: .zero, size: letterView.frame.size))
        newView.center = point
        newView.configure(with: .init(letter: letter, tintColor: nil))
        view.addSubview(newView)

        letterView.resetWithScale()

        wordView.place(newView, at: targetView) { [weak self] in
            self?.interactor?.didPlaceLetter(letter)
        }
    }
}
