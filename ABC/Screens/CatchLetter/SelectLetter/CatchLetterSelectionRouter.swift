//
//  CatchLetterRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import UIKit

final class CatchLetterRouter: CatchLetterSelectionRoutable {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = CatchLetterSelectionViewController()
        let interactor = CatchLetterSelectionInteractor(parameters: .init(alphabet: parameters.alphabet),
                                                        ui: controller,
                                                        router: self)
        controller.interactor = interactor
        self.view = controller
        return controller
    }
}
