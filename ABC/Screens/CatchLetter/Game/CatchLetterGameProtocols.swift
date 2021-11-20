//
//  CatchLetterProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

import class UIKit.UIViewController

protocol CatchLetterGameRouterDelegate: AnyObject {
    func catchLetterGameRouterDidFinishPresenting(_ controller: UIViewController)
}

protocol CatchLetterGameRoutable: Router {
    func didFinishGame()
}

protocol CatchLetterGameInteractable: AnyObject {
    func didLoad()
    func didTapCorrectLetter()
    func didTapWrongLetter()
    func finish()
}

protocol CatchLetterGameUserInterface: AnyObject {
    func configure(with letter: String, wrongLetters: [String], score: Int)
    func increaseStarsCount()
    func decreaseStarsCount()
    func onGameFinished()
}
