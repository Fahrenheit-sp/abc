//
//  WriteInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 1.11.21.
//

import Foundation

final class WriteInteractor {

    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters
    weak var ui: WriteUserInterface?
    weak var router: WriteRoutable?

    internal init(parameters: Parameters, ui: WriteUserInterface? = nil, router: WriteRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
    }
}

extension WriteInteractor: WriteInteractable {
    func didLoad() {
        print("Loaded")
    }
}
