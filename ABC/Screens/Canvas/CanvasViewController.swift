//
//  CanvasViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import UIKit

final class CanvasViewController: UIViewController {

    private let canvasAlphabetView = CanvasAlphabetView().disableAutoresizing()
    private let playButton = UIButton().disableAutoresizing()
    private let clearButton = UIButton().disableAutoresizing()

    private let viewModel: CanvasViewModel
    var interactor: CanvasInteractable?

    required init(model: CanvasViewModel) {
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(clearButton)
        view.addSubview(playButton)
        view.addSubview(canvasAlphabetView)

        canvasAlphabetView.delegate = self

        playButton.setImage(Asset.Listen.playButton.image, for: .normal)
        playButton.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)

        clearButton.setImage(Asset.Icons.recycleBin.image, for: .normal)
        clearButton.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            canvasAlphabetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            canvasAlphabetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            canvasAlphabetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            canvasAlphabetView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),

            playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 44),
            playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            clearButton.widthAnchor.constraint(equalTo: clearButton.heightAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 44),
            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func didTapClear() {
        interactor?.didClear()
        view.subviews.filter { $0 is DraggableLetterView }.forEach { $0.removeFromSuperview() }
    }

    @objc private func didTapPlay() {
        let letterViews = view.subviews.compactMap { $0 as? DraggableLetterView }
        var sortedLetters: [DraggableLetterView] = letterViews.sorted { $0.center.distance(to: .zero) < $1.center.distance(to: .zero) }
        var wordViews: [[DraggableLetterView]] = []
        while sortedLetters.count > 0 {
            guard let firstLetter = sortedLetters.first else { break }
            let wordLetterViews = sortedLetters.filter { firstLetter.frame.maxY > $0.frame.midY && firstLetter.frame.minY < $0.frame.midY  }
            wordLetterViews.forEach { sortedLetters.removeElement($0) }
            wordViews.append(wordLetterViews)
        }
        let sortedViews = wordViews.sorted { $0.first?.frame.origin.y ?? .zero < $1.first?.frame.origin.y ?? .zero }
        let words = sortedViews.map(getWord(from:))
        interactor?.didTapPlay(words: words)
    }

    private func getWord(from views: [DraggableLetterView]) -> String {
        views.compactMap { $0.letter?.symbol }.map(String.init).joined()
    }
}

extension CanvasViewController: CanvasUserInterface {
    func configure(with model: CanvasViewModel) {
        canvasAlphabetView.configure(with: model)
    }
}

extension CanvasViewController: CanvasAlphabetViewDelegate {
    func canvasView(_ canvasView: CanvasAlphabetView, didEndDragging letterView: DraggableLetterView, at point: CGPoint) {
        let newLetter = DeletableLetterView(letter: letterView.letter)
        newLetter.frame = CGRect(origin: .zero, size: letterView.frame.size)
        newLetter.center = point
        view.addSubview(newLetter)

        interactor?.didPlaceLetter()

        UIView.animate(withDuration: 0.2) {
            newLetter.transform = .init(scaleX: 1.5, y: 1.5)
        }

        letterView.resetWithScale()
    }
}
