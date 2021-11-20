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
    private let itemsToDisplayAdAtStart: [MainMenuItem] = [.alphabet, .numbers, .listen, .canvas, .catchLetter]

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
        case _ where itemsToDisplayAdAtStart.contains(item):
            view.map { presenter.presentAd(from: $0, isStartingAd: true) }
        default: wrapped.mainMenuDidSelect(item: item)
        }
    }

    func setFabricDelegate(to delegate: MainMenuNavigatable) {
        wrapped.setFabricDelegate(to: delegate)
    }

    private func proceedAfterPresentingStartingAd() {
        wrapped.mainMenuDidSelect(item: currentItem)
    }

    private func proceedFromPresentingFinishAd(from controller: UIViewController?) {
        guard let controller = controller else { return }
        switch currentItem {
        case .alphabet, .numbers:
            wrapped.alphabetRouterDidFinishPresenting(controller)
        case .makeAWord:
            wrapped.makeAWordRouterDidFinishPresenting(controller)
        case .memorize:
            wrapped.memorizeRouterDidFinishPresenting(controller)
        case .pictures:
            wrapped.picturesRouterDidFinishPresenting(controller)
        case .catchLetter:
            wrapped.catchLetterGameRouterDidFinishPresenting(controller)
        case .canvas, .listen, .subscribe: return
        }
    }

}

extension MainMenuInterstitialRouterDecorator: InterstitialPresenterDelegate {
    func presenterDidLoadAd(_ presenter: InterstitialPresenter) {
        print("Ad loaded")
    }

    func presenterDidFailToPresentAd(_ presenter: InterstitialPresenter, from controller: UIViewController?, isStartingAd: Bool) {
        isStartingAd ? proceedAfterPresentingStartingAd() : proceedFromPresentingFinishAd(from: controller)
    }

    func presenterDidDisplayAd(_ presenter: InterstitialPresenter, from controller: UIViewController?) {
        print("Ad displayed")
    }

    func presenterWillDismissAd(_ presenter: InterstitialPresenter, from controller: UIViewController?, isStartingAd: Bool) {
        isStartingAd ? proceedAfterPresentingStartingAd() : proceedFromPresentingFinishAd(from: controller)
    }

    func presenterDidDismissAd(_ presenter: InterstitialPresenter, from controller: UIViewController?) {
        print("Ad did dismiss")
    }
}

extension MainMenuInterstitialRouterDecorator: AlphabetRouterDelegate {
    func alphabetRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller, isStartingAd: false)
    }
}

extension MainMenuInterstitialRouterDecorator: MemorizeRouterDelegate {
    func memorizeRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller, isStartingAd: false)
    }
}

extension MainMenuInterstitialRouterDecorator: MakeAWordRouterDelegate {
    func makeAWordRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller, isStartingAd: false)
    }
}

extension MainMenuInterstitialRouterDecorator: SubscribeRouterDelegate {
    func subscribeRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.subscribeRouterDidFinishPresenting(controller)
    }
}

extension MainMenuInterstitialRouterDecorator: PicturesRouterDelegate {
    func picturesRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller, isStartingAd: false)
    }
}

extension MainMenuInterstitialRouterDecorator: CatchLetterGameRouterDelegate {
    func catchLetterGameRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller, isStartingAd: false)
    }
}
