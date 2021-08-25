//
//  CanvasScreenViewModel.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import Foundation

struct CanvasViewModel {

    private let canvas: Canvas
    let numberOfRows: Int

    init(canvas: Canvas) {
        self.canvas = canvas
        self.numberOfRows = canvas.numberOfCanvasRows
    }

    func numberOfLetters(in row: Int) -> Int {
        canvas.numberOfCanvasLetters(in: row)
    }

    func letter(at indexPath: IndexPath) -> Letter {
        canvas.canvasLetter(at: indexPath)
    }

    func letters(in row: Int) -> [Letter] {
        canvas.canvasLetters(in: row)
    }
}
