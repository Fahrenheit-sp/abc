//
//  AlphabetRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetRouter: AlphabetRoutable {

    private weak var view: UIViewController?

    func makeController() -> UIViewController {
        let view = AlphabetViewController()
        let interactor = AlphabetInteractor()
        interactor.router = self
        interactor.ui = view
        view.interactor = interactor

        self.view = view

        return view
    }
}
