//
//  ListenScreenRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import UIKit

final class ListenRouter: ListenRoutable {

    struct Parameters {
        let alphabet: Alphabet
        let mode: AlphabetViewMode
    }

    private let parameters: Parameters

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = ListenViewController(model: .init(alphabet: parameters.alphabet),
                                              configuration: .init(spacing: parameters.mode.spacing))
        let interactor = ListenInteractor(parameters: .init(alphabet: parameters.alphabet),
                                          router: self,
                                          ui: controller)

        controller.interactor = interactor
        return controller
    }
}
