//
//  AlphabetProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import class UIKit.UIViewController

protocol AlphabetRouterDelegate: AnyObject {
    func alphabetRouterDidFinishPresenting(_ controller: UIViewController)
}

protocol AlphabetRoutable: Router {
    func finish()
}

protocol AlphabetInteractable: AnyObject {
    func didLoad()
    func didPlaceLetter(_ letter: Letter)

    func getNextLetter() -> Letter?
    func finish()
}

protocol AlphabetUserInterface: AnyObject {
    func configure(with model: AlphabetScreenViewModel)
    func didFinish()
}
