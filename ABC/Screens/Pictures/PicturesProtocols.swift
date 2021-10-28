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
}

protocol PicturesUserInterface: UIViewController {
    var interactor: PicturesInteractable? { get set }
    func configure(with model: MainMenuScreenViewModel)
}
