//
//  ListenViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import UIKit

final class ListenViewController: UIViewController {

    var interactor: ListenInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .white
    }

}

extension ListenViewController: ListenUserInterface {

}
