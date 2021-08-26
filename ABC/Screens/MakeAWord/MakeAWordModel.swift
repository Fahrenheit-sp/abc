//
//  MakeAWordModel.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import Foundation

struct MakeAWordViewModel {

    let word: Word
    let canvas: Canvas

    init(word: Word, canvas: Canvas) {
        self.word = word
        self.canvas = canvas
    }
}
