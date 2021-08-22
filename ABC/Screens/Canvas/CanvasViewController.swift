//
//  CanvasViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import UIKit

final class CanvasViewController: UIViewController {

    var interactor: CanvasInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()

        interactor?.didLoad()
    }

}

extension CanvasViewController: CanvasUserInterface {
    func configure(with model: CanvasScreenViewModel) {
        view.backgroundColor = .yellow
    }
}
