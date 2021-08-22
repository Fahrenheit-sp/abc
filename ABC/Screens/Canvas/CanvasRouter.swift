//
//  CanvasRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import UIKit

final class CanvasRouter: CanvasRoutable {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters

    init(parameters: CanvasRouter.Parameters) {
        self.parameters = parameters
    }
    
    func makeController() -> UIViewController {
        let controller = CanvasViewController()
        controller.interactor = CanvasInteractor(ui: controller, router: self)
        return controller
    }
}
