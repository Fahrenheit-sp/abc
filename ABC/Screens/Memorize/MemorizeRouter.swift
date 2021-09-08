//
//  MemorizeRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

final class MemorizeRouter: MemorizeRoutable {

    struct Parameters {
        let memorizable: Memorizable & Alphabet
    }

    private let parameters: Parameters
    private weak var view: UIViewController?
    weak var delegate: MemorizeRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = MemorizeViewController()
        controller.interactor = MemorizeInteractor(memorizable: parameters.memorizable, ui: controller, router: self)
        view = controller
        return controller
    }

    func didFinishGame() {
        view.map { delegate?.memorizeRouterDidFinishPresenting($0) }
    }
}
