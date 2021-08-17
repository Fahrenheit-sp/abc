//
//  AlphabetInteractor.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

final class AlphabetInteractor: AlphabetInteractable {

    var ui: AlphabetUserInterface?
    weak var router: AlphabetRoutable?
    
    func didLoad() {
        print("Loaded")
    }

    func didPlaceLetter() {
        print("Placed")
    }

    func didMissLetter() {
        print("Missed")
    }
}
