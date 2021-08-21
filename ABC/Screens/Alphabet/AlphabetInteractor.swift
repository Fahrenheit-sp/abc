//
//  AlphabetInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

final class AlphabetInteractor: AlphabetInteractable {

    #warning("Probably not needed or need to move logic from VM")
    struct Parameters {
        let alphabet: Alphabet
    }

    private let parameters: Parameters

    var ui: AlphabetUserInterface?
    weak var router: AlphabetRoutable?

    internal init(parameters: Parameters, ui: AlphabetUserInterface? = nil, router: AlphabetRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
    }
    
    func didLoad() {
        ui?.configure(with: .init(alphabet: parameters.alphabet))
    }

    func didPlaceLetter() {
        print("Placed")
    }

    func didMissLetter() {
        print("Missed")
    }
}
