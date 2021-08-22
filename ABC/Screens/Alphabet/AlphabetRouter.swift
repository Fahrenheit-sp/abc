//
//  AlphabetRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetRouter: AlphabetRoutable {

    struct Configuration {
        let insets: UIEdgeInsets
        let spacing: CGFloat

        static let alphabet = Self.init(insets: .zero, spacing: UIScreen.main.bounds.width > 400 ? 8 : 0)
        static let numbers = Self.init(insets: .init(top: 32, left: 32, bottom: 0, right: 32), spacing: 16)
    }

    struct Parameters {
        let alphabet: Alphabet
        let configuration: Configuration
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = AlphabetViewController(viewModel: .init(alphabet: parameters.alphabet),
                                          configuration: .init(insets: parameters.configuration.insets, spacing: parameters.configuration.spacing))
        let interactor = AlphabetInteractor(parameters: .init(alphabet: parameters.alphabet, mode: .ordered))
        interactor.router = self
        interactor.ui = view
        view.interactor = interactor

        self.view = view

        return view
    }
}
