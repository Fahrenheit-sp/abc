//
//  CanvasInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import Foundation

final class CanvasInteractor: CanvasInteractable {

    struct Parameters {
        let canvas: Canvas
    }

    private let parameters: Parameters
    private let player: SoundPlayer
    weak var ui: CanvasUserInterface?
    weak var router: CanvasRoutable?

    init(parameters: Parameters, ui: CanvasUserInterface? = nil, router: CanvasRoutable? = nil) {
        self.parameters = parameters
        self.player = SoundPlayer()
        self.ui = ui
        self.router = router
    }

    func didLoad() {
        ui?.configure(with: .init(canvas: parameters.canvas))
    }

    func didPlaceLetter() {
        player.playLetterPlacedSound()
    }

    func didClear() {
        player.playSwooshSound()
    }
    
}
