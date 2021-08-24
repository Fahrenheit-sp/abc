//
//  CanvasRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import UIKit

final class CanvasRouter: CanvasRoutable {

    struct Parameters {
        let canvas: Canvas
    }

    private let parameters: Parameters

    init(parameters: CanvasRouter.Parameters) {
        self.parameters = parameters
    }
    
    func makeController() -> UIViewController {
        let model = CanvasViewModel(canvas: parameters.canvas)
        let controller = CanvasViewController(model: model)
        controller.interactor = CanvasInteractor(parameters: .init(canvas: parameters.canvas), ui: controller, router: self)
        return controller
    }
}
