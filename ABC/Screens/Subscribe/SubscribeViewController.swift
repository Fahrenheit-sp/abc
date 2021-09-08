//
//  SubscribeViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import UIKit

final class SubscribeViewController: UIViewController {

    var interactor: SubscribeInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background
    }
}

extension SubscribeViewController: SubscribeUserInterface {
    func configure() {
        
    }
}
