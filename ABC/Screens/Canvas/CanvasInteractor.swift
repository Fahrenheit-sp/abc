//
//  CanvasInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import Foundation

final class CanvasInteractor: CanvasInteractable {

    var ui: CanvasUserInterface?
    weak var router: CanvasRoutable?

    init(ui: CanvasUserInterface? = nil, router: CanvasRoutable? = nil) {
        self.ui = ui
        self.router = router
    }

    func didLoad() {
        ui?.configure(with: .init())
    }
    
}
