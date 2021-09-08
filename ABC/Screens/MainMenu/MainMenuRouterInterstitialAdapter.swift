//
//  MainMenuRouterInterstitialAdapter.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import UIKit

final class MainMenuInterstitialRouterAdapter: NSObject, MainMenuRoutable {

    private let adaptee: MainMenuRouter
    private let presenter: InterstitialPresenter
    private var currentItem: MainMenuItem = .alphabet

    var view: MainMenuUserInterface? {
        adaptee.view
    }

    init(adaptee: MainMenuRouter) {
        self.adaptee = adaptee
        self.presenter = InterstitialPresenter()
        super.init()
        presenter.delegate = self
        presenter.loadAd()
    }

    func makeController() -> UIViewController {
        let root = adaptee.makeController()
        view.map { $0.interactor = adaptee.makeInteractor(for: $0, router: self) }
        return root
    }

    func mainMenuDidSelect(item: MainMenuItem) {
        currentItem = item
        switch item {
        case .listen, .canvas: view.map { presenter.presentAd(from: $0) }
        default: adaptee.mainMenuDidSelect(item: item)
        }
    }

}

extension MainMenuInterstitialRouterAdapter: InterstitialPresenterDelegate {
    func presenterDidLoadAd(_ presenter: InterstitialPresenter) {
        print("Ad loaded")
    }

    func presenterDidFailToPresentAd(_ presenter: InterstitialPresenter) {
        adaptee.mainMenuDidSelect(item: currentItem)
    }

    func presenterDidDisplayAd(_ presenter: InterstitialPresenter) {
        print("Ad displayed")
    }

    func presenterWillDismissAd(_ presenter: InterstitialPresenter) {
        print("Ad will dismiss")
        adaptee.mainMenuDidSelect(item: currentItem)
    }

    func presenterDidDismissAd(_ presenter: InterstitialPresenter) {
        print("Ad did dismiss")
    }
}
/*
final class MainMenuInterstitialRouterAdapter: MainMenuRouter {
    private let presenter: InterstitialPresenter
    private var currentItem: MainMenuItem = .alphabet

    override init(parameters: MainMenuRouter.Parameters) {
        self.presenter = InterstitialPresenter()
        super.init(parameters: parameters)
        presenter.delegate = self
        presenter.loadAd()
    }

    override func mainMenuDidSelect(item: MainMenuItem) {
        currentItem = item
        switch item {
        case .listen, .canvas: navigation.map { presenter.presentAd(from: $0) }
        default: super.mainMenuDidSelect(item: item)
        }
    }

    override func makeInteractor(for ui: MainMenuUserInterface, router: MainMenuRoutable) -> MainMenuInteractable {
        super.makeInteractor(for: ui, router: self)
    }
}

extension MainMenuInterstitialRouterAdapter: InterstitialPresenterDelegate {
    func presenterDidLoadAd(_ presenter: InterstitialPresenter) {
        print("Ad loaded")
    }

    func presenterDidDisplayAd(_ presenter: InterstitialPresenter) {
        print("Ad displayed")
    }

    func presenterWillDismissAd(_ presenter: InterstitialPresenter) {
        print("Ad will dismiss")
        super.mainMenuDidSelect(item: currentItem)
    }

    func presenterDidDismissAd(_ presenter: InterstitialPresenter) {
        print("Ad did dismiss")
    }
}
*/
