//
//  AlphabetViewProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import Foundation

protocol AlphabetViewDataSource: AnyObject {
    func state(for letter: Letter) -> LetterView.State
}

protocol AlphabetViewDelegate: AnyObject {
    func alphabetView(_ alphabetView: AlphabetView, didSelect letter: Letter)
}
