//
//  CatchLetterProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

protocol CatchLetterSelectionRoutable: Router {}

protocol CatchLetterSelectionInteractable: AnyObject {
    func didLoad()
    func onLetterSelected()
    func getNextLetter() -> Letter
    func getPreviousLetter() -> Letter
}

protocol CatchLetterSelectionUserInterface: AnyObject {
}
