//
//  ListenInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import Foundation

final class ListenInteractor: ListenInteractable {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    weak var router: ListenRoutable?
    var ui: ListenUserInterface

    internal init(parameters: ListenInteractor.Parameters, router: ListenRoutable? = nil, ui: ListenUserInterface) {
        self.parameters = parameters
        self.router = router
        self.ui = ui
    }

    func didLoad() {
        ui.configure(with: .init(alphabet: parameters.alphabet))
    }
}
