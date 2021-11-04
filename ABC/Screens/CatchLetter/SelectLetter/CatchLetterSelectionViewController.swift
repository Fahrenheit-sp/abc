//
//  CatchLetterSelectionViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import UIKit

final class CatchLetterSelectionViewController: UIViewController {

    var interactor: CatchLetterSelectionInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background
    }

}

extension CatchLetterSelectionViewController: CatchLetterSelectionUserInterface {

}
