//
//  CatchLetterProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 4.11.21.
//

protocol CatchLetterGameRoutable: Router {}

protocol CatchLetterGameInteractable: AnyObject {
    func didLoad()
}

protocol CatchLetterGameUserInterface: AnyObject {
    func configure(with letter: String)
}
