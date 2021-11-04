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

    private var gameRouter: Router?

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

    func didSelectLetter(_ letter: Letter) {
        gameRouter = CatchLetterGameRouter(parameters: .init(alphabet: parameters.alphabet, letter: letter))
        let root = view?.navigationController?.viewControllers.first
        let game = gameRouter?.makeController()
        view?.navigationController?.setViewControllers([root, game].compactMap {$0}, animated: true)
    }
}
