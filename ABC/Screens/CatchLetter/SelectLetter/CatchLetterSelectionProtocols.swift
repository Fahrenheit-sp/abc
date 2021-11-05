//
//  CatchLetterProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

protocol CatchLetterSelectionRoutable: Router {
    func didSelectLetter(_ letter: Letter)
}

protocol CatchLetterSelectionInteractable: AnyObject {
    func didLoad()
    func onLetterSelected()
    func onNextLetterTap()
    func onPreviousLetterTap()
}

protocol CatchLetterSelectionUserInterface: AnyObject {
    func configure(with letterModel: LetterViewModel)
}
