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
    weak var delegate: MakeAWordRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = MemorizeViewController()
        controller.interactor = MemorizeInteractor(memorizable: parameters.memorizable, ui: controller, router: self)
        return controller
    }

    func didFinishGame() {
        delegate?.makeAWordRouterDidFinish(self)
    }
}
