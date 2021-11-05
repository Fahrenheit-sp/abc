//
//  MainMenuProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation
import class UIKit.UIViewController

typealias MainMenuNavigatable = AlphabetRouterDelegate
                                    & MemorizeRouterDelegate
                                    & MakeAWordRouterDelegate
                                    & SubscribeRouterDelegate
                                    & PicturesRouterDelegate
                                    & CatchLetterGameRouterDelegate

protocol MainMenuRoutable: Router, MainMenuNavigatable {
    func mainMenuDidSelect(item: MainMenuItem)
    func setInteractorDelegate(to router: MainMenuRoutable)
    func setFabricDelegate(to delegate: MainMenuNavigatable)
}

protocol MainMenuInteractable: AnyObject {
    func didLoad()
    func didPressEnableSound()
    func didPressDisableSound()
    func didPressSubscribe()
    func didSelectItem(at indexPath: IndexPath)
}

protocol MainMenuUserInterface: UIViewController {
    var interactor: MainMenuInteractable? { get set }
    func configure(with model: MainMenuScreenViewModel)
}
