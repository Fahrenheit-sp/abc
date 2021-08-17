//
//  AlphabetRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetRouter: AlphabetRoutable {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = AlphabetViewController(viewModel: .init(alphabet: parameters.alphabet))
        let interactor = AlphabetInteractor()
        interactor.router = self
        interactor.ui = view
        view.interactor = interactor

        self.view = view

        return view
    }
}
