//
//  CatchLetterRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import UIKit

final class CatchLetterGameRouter: CatchLetterGameRoutable {

    struct Parameters {
        let alphabet: Alphabet
        let letter: Letter
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = CatchLetterGameViewController()
        let interactor = CatchLetterGameInteractor(parameters: .init(alphabet: parameters.alphabet, letter: parameters.letter),
                                                        ui: controller,
                                                        router: self)
        controller.interactor = interactor
        self.view = controller
        return controller
    }
}
