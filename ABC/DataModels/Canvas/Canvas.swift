//
//  CanvasDataSource.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import Foundation

protocol Canvas {
    var numberOfCanvasRows: Int { get }
    func numberOfCanvasLetters(in row: Int) -> Int
    func canvasLetters(in row: Int) -> [Letter]
    func canvasLetter(at indexPath: IndexPath) -> Letter
}

extension Canvas where Self: Alphabet {
    func canvasLetters(in row: Int) -> [Letter] {
        guard row >= 0  && row <= numberOfRows-1 else { return [] }
        let lettersToSkip = (0 ..< row).reduce(0) { $0 + numberOfCanvasLetters(in: $1) }
        return Array(letters.dropFirst(lettersToSkip).prefix(numberOfCanvasLetters(in: row)))
    }

    func canvasLetter(at indexPath: IndexPath) -> Letter {
        guard indexPath.section > 0 else { return letters[indexPath.item] }
        let index = (0 ..< indexPath.section).reduce(0) { $0 + numberOfCanvasLetters(in: $1) } + indexPath.item
        guard index < letters.endIndex else { return Letter(symbol: "a") }
        return letters[index]
    }
}
