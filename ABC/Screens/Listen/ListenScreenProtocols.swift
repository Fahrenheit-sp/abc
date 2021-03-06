//
//  ListenScreenProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import Foundation

protocol ListenRoutable: Router {}

protocol ListenInteractable: AnyObject {
    func didLoad()
    func didPressPlay()
    func didSelect(letter: Letter)
}

protocol ListenUserInterface: AnyObject {
    func configure(with model: ListenViewModel)
    func handleWrongSelection(of letter: Letter)
}
