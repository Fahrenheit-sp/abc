//
//  MakeAWordInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import Foundation

final class MakeAWordInteractor: MakeAWordInteractable {

    struct Parameters {
        let wordsStorage: WordsStorable
        let canvas: Canvas
    }

    private let parameters: Parameters
    var ui: MakeAWordUserInterface?
    weak var router: MakeAWordRoutable?
    private let words: [Word]

    init(parameters: Parameters, ui: MakeAWordUserInterface? = nil, router: MakeAWordRoutable? = nil) {
        self.parameters = parameters
        self.ui = ui
        self.router = router
        self.words = parameters.wordsStorage.getWords()
    }

    func didLoad() {
        words.randomElement().map { ui?.configure(with: .init(word: $0, canvas: parameters.canvas)) }
    }
}
