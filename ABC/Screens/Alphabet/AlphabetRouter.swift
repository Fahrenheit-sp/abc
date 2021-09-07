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
        let mode: AlphabetViewMode
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = AlphabetViewController(viewModel: .init(alphabet: parameters.alphabet),
                                          configuration: .init(insets: parameters.mode.insets,
                                                               spacing: parameters.mode.spacing))
        let interactor = AlphabetInteractor(parameters: .init(alphabet: parameters.alphabet, mode: .shuffled))
        interactor.router = self
        interactor.ui = view
        view.interactor = interactor

        self.view = view

        return view
    }
}
