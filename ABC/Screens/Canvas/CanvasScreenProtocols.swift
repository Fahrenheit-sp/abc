//
//  CanvasScreenProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 22.08.21.
//

import Foundation

protocol CanvasRoutable: Router {}

protocol CanvasInteractable: AnyObject {
    func didLoad()
    func didPlaceLetter()
    func didClear()
    func didTapPlay(words: [String])
}

protocol CanvasUserInterface: AnyObject {
    func configure(with model: CanvasViewModel)
}
