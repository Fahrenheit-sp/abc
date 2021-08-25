//
//  MemorizeRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import UIKit

final class MemorizeRouter: MemorizeRoutable {

    struct Parameters {
        let memorizable: Memorizable
    }

    private let parameters: Parameters

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let model = MemorizeViewModel()
        let controller = MemorizeViewController()
        controller.interactor = MemorizeInteractor(ui: controller, router: self)
        return controller
    }
}
