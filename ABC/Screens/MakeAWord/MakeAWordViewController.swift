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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(canvasView)

        NSLayoutConstraint.activate([
            canvasView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            canvasView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            canvasView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            canvasView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.23)
        ])
    }

}

extension MakeAWordViewController: MakeAWordUserInterface {
    func configure(with model: MakeAWordViewModel) {
        canvasView.configure(with: .init(canvas: model.canvas))
    }
}
