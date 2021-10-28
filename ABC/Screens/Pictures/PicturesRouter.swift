//
//  PicturesRouter.swift
//  ABC
//
//  Created by Игорь Майсюк on 28.10.21.
//

import UIKit

final class PicturesRouter: PicturesRoutable {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    private weak var view: UIViewController?

    weak var delegate: PicturesRouterDelegate?

    init(parameters: Parameters) {
        self.parameters = parameters
    }

    func makeController() -> UIViewController {
        let view = PicturesViewController()
        let interactor = PicturesInteractor(parameters: .init(alphabet: parameters.alphabet), ui: view, router: self)
        view.interactor = interactor

        self.view = view

        return view
    }

    func finish() {
        view.map { delegate?.picturesRouterDidFinishPresenting($0) }
    }
}
