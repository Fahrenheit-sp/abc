//
//  CanvasViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import UIKit

final class CanvasViewController: UIViewController {

    private let canvasAlphabetView = CanvasAlphabetView().disableAutoresizing()
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
        view.backgroundColor = .white
        view.addSubview(clearButton)
        view.addSubview(canvasAlphabetView)

        canvasAlphabetView.lettersDelegate = self

        clearButton.setTitle(L10n.Canvas.clear.uppercased(), for: .normal)
        clearButton.setTitleColor(.systemBlue, for: .normal)
        clearButton.addTarget(self, action: #selector(didTapClear), for: .touchUpInside)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            canvasAlphabetView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            canvasAlphabetView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            canvasAlphabetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            canvasAlphabetView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23),

            clearButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    @objc private func didTapClear() {
        view.subviews.filter { $0 is DraggableLetterView }.forEach { $0.removeFromSuperview() }
    }
}

extension CanvasViewController: CanvasUserInterface {
    func configure(with model: CanvasViewModel) {
        canvasAlphabetView.configure(with: model)
    }
}

extension CanvasViewController: DraggableLetterViewDelegate {
    func draggableViewDidEndDragging(_ letterView: DraggableLetterView) {
        let newLetter = DeletableLetterView(letter: letterView.letter)
        newLetter.frame = CGRect(origin: .zero, size: letterView.frame.size)
        newLetter.center = letterView.superview?.convert(letterView.center, to: nil) ?? .zero
        view.addSubview(newLetter)

        UIView.animate(withDuration: 0.2) {
            newLetter.transform = .init(scaleX: 2, y: 2)
        }
        
        letterView.resetWithScale()
    }
}