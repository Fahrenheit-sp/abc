//
//  MakeAWordProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import Foundation

protocol MakeAWordRoutable: AnyObject, Router {
}

protocol MakeAWordInteractable: AnyObject {
    func didLoad()
    func didPlaceLetter(_ letter: Letter)
}

protocol MakeAWordUserInterface: AnyObject {
    func configureCanvas(with canvas: Canvas)
    func configureWord(with word: Word)
    func configureStarsCount(to count: Int)
    func didFinishWord()
    func didFinishGame()
}