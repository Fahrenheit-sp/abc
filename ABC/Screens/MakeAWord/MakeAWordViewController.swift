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
        view.backgroundColor = .white
        view.addSubview(starsView)
        view.addSubview(canvasView)
        view.addSubview(wordView)

        canvasView.delegate = self

        NSLayoutConstraint.activate([
            starsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            starsView.heightAnchor.constraint(equalToConstant: 36),
            starsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),

            wordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            wordView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 8),
            wordView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -8)
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
        print("Finished")
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
        let newView = LetterView(frame: CGRect(origin: .zero, size: letterView.frame.size))
        newView.center = point
        newView.configure(with: .init(letter: letter, tintColor: nil))
        view.addSubview(newView)

        letterView.resetWithScale()

        UIView.animate(withDuration: 0.3) { [self] in
            newView.frame = view.convert(targetView.frame, from: wordView)
        } completion: { [weak self] _ in
            targetView.configure(with: .init(letter: letter, tintColor: nil))
            newView.removeFromSuperview()
            self?.interactor?.didPlaceLetter(letter)
        }
    }
}
