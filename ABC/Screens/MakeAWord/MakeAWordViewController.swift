//
//  MakeAWordViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class MakeAWordViewController: UIViewController {

    var interactor: MakeAWordInteractable?

    private let canvasView = CanvasAlphabetView().disableAutoresizing()
    private var wordView: WordView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(canvasView)

        canvasView.delegate = self

        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23)
        ])
    }

}

extension MakeAWordViewController: MakeAWordUserInterface {

    func configureCanvas(with canvas: Canvas) {
        canvasView.configure(with: .init(canvas: canvas))
    }

    func configureWord(with word: Word) {
        wordView?.removeFromSuperview()

        let wordView = WordView(word: word).disableAutoresizing()
        self.wordView = wordView
        view.addSubview(wordView)

        NSLayoutConstraint.activate([
            wordView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            wordView.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 8),
            wordView.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -8)
        ])
    }
}

extension MakeAWordViewController: CanvasAlphabetViewDelegate {
    func canvasView(_ canvasView: CanvasAlphabetView, didEndDragging letterView: DraggableLetterView, at point: CGPoint) {
        guard let overLetterView = wordView?.letterView(at: point) else { return letterView.reset() }
        guard let letter = letterView.letter else { return letterView.reset() }
        guard letter == overLetterView.letter else { return letterView.reset() }
        let newView = LetterView(frame: CGRect(origin: .zero, size: letterView.frame.size))
        newView.center = point
        newView.configure(with: .init(letter: letter, tintColor: nil))
        view.addSubview(newView)

        letterView.resetWithScale()

        UIView.animate(withDuration: 0.3) { [self] in
            newView.frame = view.convert(overLetterView.frame, from: wordView)
        } completion: { [weak self] _ in
            overLetterView.configure(with: .init(letter: letter, tintColor: nil))
            newView.removeFromSuperview()
            self?.interactor?.didPlaceLetter(letter)
        }
    }

    func didFinishWord() {
        print("Word finished")
    }
}
