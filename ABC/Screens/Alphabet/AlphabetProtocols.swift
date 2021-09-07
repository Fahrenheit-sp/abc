//
//  AlphabetProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

protocol AlphabetRouterDelegate: AnyObject {
    func alphabetRouterDidFinish(_ router: Router)
}

protocol AlphabetRoutable: AnyObject, Router {
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
