//
//  WriteRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 1.11.21.
//

import UIKit

final class WriteRouter: WriteRoutable {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    weak var delegate: WriteRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = WriteViewController()
        let interactor = WriteInteractor(parameters: .init(alphabet: parameters.alphabet),
                                            ui: view,
                                            router: self)
        view.interactor = interactor

        self.view = view

        return view
    }

    func finish() {
        view.map { delegate?.writeRouterDidFinishPresenting($0) }
    }
}
