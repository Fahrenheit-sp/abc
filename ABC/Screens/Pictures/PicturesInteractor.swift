//
//  PicturesInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 28.10.21.
//

import Foundation

final class PicturesInteractor: PicturesInteractable {

    struct Parameters {
        let wordsCount: Int = 5
        let canvas: Canvas
    }

    private let parameters: Parameters

    weak var ui: PicturesUserInterface?
    weak var router: PicturesRoutable?

    internal init(parameters: Parameters, ui: PicturesUserInterface? = nil, router: PicturesRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
    }

    func didLoad() {
        ui?.configureStarsCount(to: parameters.wordsCount)
        ui?.setImage(named: "apple")
        ui?.configureCanvas(with: parameters.canvas)
    }
}
