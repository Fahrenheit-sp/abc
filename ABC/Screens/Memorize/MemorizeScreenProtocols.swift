//
//  MemorizeProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

protocol MemorizeRoutable: AnyObject, Router {
    func didFinishGame()
}

protocol MemorizeInteractable: AnyObject {
    func didLoad()
    func didOpenLetter(at indexPath: IndexPath)
}

protocol MemorizeUserInterface: AnyObject {
    func configure(with model: MemorizeViewModel)
    func didOpenSameLetters(at indexPaths: [IndexPath])
    func didOpenWrongLetters(at indexPaths: [IndexPath])
}