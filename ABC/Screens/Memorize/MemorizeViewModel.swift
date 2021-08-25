//
//  MemorizeViewModel.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

struct MemorizeViewModel {

    private let memorizable: Memorizable
    private let letters: [Letter]

    var numberOfRows: Int {
        memorizable.numberOfMemorizeRows
    }

    var numberOfColumns: Int {
        memorizable.numberOfMemorizeColumns
    }

    init(memorizable: Memorizable = AlphabetsFactory.getAlphabet(.english), letters: [Letter] = []) {
        self.memorizable = memorizable
        self.letters = letters
    }

    func cellModel(at indexPath: IndexPath) -> MemorizeCellViewModel {
        let index = (indexPath.section * numberOfColumns) + indexPath.row
        let letter = letters[index]
        return .init(letter: letter)
    }
}
