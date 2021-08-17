//
//  MainMenuProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

protocol MainMenuRoutable: AnyObject, Router {
    func mainMenuDidSelect(item: MainMenuItem)
}

protocol MainMenuInteractable: AnyObject {
    func didLoad()
    func didSelectItem(at indexPath: IndexPath)
}

protocol MainMenuUserInterface: AnyObject {
    func configure(with model: MainMenuScreenViewModel)
}
