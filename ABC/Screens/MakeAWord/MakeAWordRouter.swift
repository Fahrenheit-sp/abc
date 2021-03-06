//
//  MakeAWordRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import UIKit

final class MakeAWordRouter: MakeAWordRoutable {

    struct Parameters {
        let canvas: Canvas
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    weak var delegate: MakeAWordRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let controller = MakeAWordViewController()
        controller.interactor = MakeAWordInteractor(parameters: .init(wordsStorage: WordsStorage.shared,
                                                                      canvas: parameters.canvas),
                                                    ui: controller,
                                                    router: self)
        self.view = controller
        return controller
    }

    func finish() {
        view.map { delegate?.makeAWordRouterDidFinishPresenting($0) }
    }
}
