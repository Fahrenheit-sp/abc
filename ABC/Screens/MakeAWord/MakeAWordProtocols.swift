//
//  MakeAWordProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import class UIKit.UIViewController

protocol MakeAWordRouterDelegate: AnyObject {
    func makeAWordRouterDidFinishPresenting(_ controller: UIViewController)
}

protocol MakeAWordRoutable: AnyObject, Router {
    func finish()
}

protocol MakeAWordInteractable: AnyObject {
    func didLoad()
    func didPlaceLetter(_ letter: Letter)
    func finish()
}

protocol MakeAWordUserInterface: AnyObject {
    func configureCanvas(with canvas: Canvas)
    func configureWord(with word: Word)
    func configureStarsCount(to count: Int)
    func didFinishWord()
    func didFinishGame()
}
