//
//  MemorizeInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

final class MemorizeInteractor: MemorizeInteractable {

    var ui: MemorizeUserInterface?
    weak var router: MemorizeRoutable?

    internal init(ui: MemorizeUserInterface? = nil, router: MemorizeRoutable? = nil) {
        self.ui = ui
        self.router = router
    }

    func didLoad() {
        ui?.configure(with: .init())
    }
}
