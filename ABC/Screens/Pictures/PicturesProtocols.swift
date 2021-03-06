//
//  PicturesProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 28.10.21.
//

import UIKit

protocol PicturesRouterDelegate: AnyObject {
    func picturesRouterDidFinishPresenting(_ controller: UIViewController)
}

protocol PicturesRoutable: Router {
    func finish()
}

protocol PicturesInteractable: AnyObject {
    func didLoad()
    func speakCurrentPicture()
    func playLetterPlacedSound()
    func playLetterRemovedSound()
    func validate(word: String)
    func finish()
}

protocol PicturesUserInterface: UIViewController {
    var interactor: PicturesInteractable? { get set }

    func configureStarsCount(to count: Int)
    func setPicture(named name: String)
    func didFinishPicture()
    func didFinishGame()
}
