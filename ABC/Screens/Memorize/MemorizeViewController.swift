//
//  MemorizeViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

final class MemorizeViewController: UIViewController {

    var interactor: MemorizeInteractable?

    let card = CardView(letter: Letter(symbol: "a")).disableAutoresizing()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white

        view.addSubview(card)

        NSLayoutConstraint.activate([
            card.widthAnchor.constraint(equalToConstant: 100),
            card.heightAnchor.constraint(equalToConstant: 200),
            card.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            card.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

}

extension MemorizeViewController: MemorizeUserInterface {
    func configure(with model: MemorizeViewModel) {
        
    }
}
