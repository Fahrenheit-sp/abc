//
//  MainMenuRouterInterstitialAdapter.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import UIKit

final class MainMenuInterstitialRouterDecorator: NSObject, MainMenuRoutable {

    private let wrapped: MainMenuRouter
    private let presenter: InterstitialPresenter
    private var currentItem: MainMenuItem = .alphabet
    private var itemsToDisplayAdAtStart: [MainMenuItem] = [.listen, .canvas]

    private var controllerPresentingAd: UIViewController?

    private var view: MainMenuUserInterface? {
        wrapped.view
    }

    init(adaptee: MainMenuRouter) {
        self.wrapped = adaptee
        self.presenter = InterstitialPresenter()
        super.init()
        presenter.delegate = self
        presenter.loadAd()
    }

    func makeController() -> UIViewController {
        let controller = wrapped.makeController()
        setFabricDelegate(to: self)
        setInteractorDelegate(to: self)
        return controller
    }

    func setInteractorDelegate(to router: MainMenuRoutable) {
        wrapped.setInteractorDelegate(to: router)
    }

    func mainMenuDidSelect(item: MainMenuItem) {
        currentItem = item
        switch item {
        case .listen, .canvas: view.map { presenter.presentAd(from: $0) }
        default: wrapped.mainMenuDidSelect(item: item)
        }
    }

    func setFabricDelegate(to delegate: MainMenuNavigatable) {
        wrapped.setFabricDelegate(to: delegate)
    }

    private func procceedAfterPresentingAd() {
        if itemsToDisplayAdAtStart.contains(currentItem) {
            wrapped.mainMenuDidSelect(item: currentItem)
        } else {
            guard let controller = controllerPresentingAd else { return }
            switch currentItem {
            case .alphabet, .numbers:
                wrapped.alphabetRouterDidFinishPresenting(controller)
            case .makeAWord:
                wrapped.makeAWordRouterDidFinishPresenting(controller)
            case .memorize:
                wrapped.memorizeRouterDidFinishPresenting(controller)
            case .canvas, .listen, .subscribe: return
            }
            controllerPresentingAd = nil
        }
    }

}

extension MainMenuInterstitialRouterDecorator: InterstitialPresenterDelegate {
    func presenterDidLoadAd(_ presenter: InterstitialPresenter) {
        print("Ad loaded")
    }

    func presenterDidFailToPresentAd(_ presenter: InterstitialPresenter) {
        procceedAfterPresentingAd()
    }

    func presenterDidDisplayAd(_ presenter: InterstitialPresenter) {
        print("Ad displayed")
    }

    func presenterWillDismissAd(_ presenter: InterstitialPresenter) {
        procceedAfterPresentingAd()
    }

    func presenterDidDismissAd(_ presenter: InterstitialPresenter) {
        print("Ad did dismiss")
    }
}

extension MainMenuInterstitialRouterDecorator: AlphabetRouterDelegate {
    func alphabetRouterDidFinishPresenting(_ controller: UIViewController) {
        controllerPresentingAd = controller
        presenter.presentAd(from: controller)
    }
}

extension MainMenuInterstitialRouterDecorator: MemorizeRouterDelegate {
    func memorizeRouterDidFinishPresenting(_ controller: UIViewController) {
        controllerPresentingAd = controller
        presenter.presentAd(from: controller)
    }
}

extension MainMenuInterstitialRouterDecorator: MakeAWordRouterDelegate {
    func makeAWordRouterDidFinishPresenting(_ controller: UIViewController) {
        controllerPresentingAd = controller
        presenter.presentAd(from: controller)
    }
}

extension MainMenuInterstitialRouterDecorator: SubscribeRouterDelegate {
    func subscribeRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.subscribeRouterDidFinishPresenting(controller)
    }
}
