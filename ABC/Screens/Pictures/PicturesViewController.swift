//
//  PicturesViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 28.10.21.
//

import UIKit

final class PicturesViewController: UIViewController {
    var interactor: PicturesInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background
    }
}

extension PicturesViewController: PicturesUserInterface {
    func configure(with model: MainMenuScreenViewModel) {
        
    }
}
