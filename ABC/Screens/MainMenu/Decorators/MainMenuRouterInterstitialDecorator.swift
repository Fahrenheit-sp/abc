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
    private let itemsToDisplayAdAtStart: [MainMenuItem] = [.listen, .canvas, .catchLetter]
    private let itemsToDisplayAdAtEnd: [MainMenuItem] = [.alphabet, .numbers, .makeAWord, .memorize, .pictures, .catchLetter]
    private var isPresentingFromStart = true

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
            isPresentingFromStart = true
            view.map { presenter.presentAd(from: $0) }
        default: wrapped.mainMenuDidSelect(item: item)
        }
    }

    func setFabricDelegate(to delegate: MainMenuNavigatable) {
        wrapped.setFabricDelegate(to: delegate)
    }

    private func proceedAfterPresentingAd(from controller: UIViewController?) {
        switch currentItem {
        case _ where itemsToDisplayAdAtStart.contains(currentItem) && isPresentingFromStart:
            isPresentingFromStart = false
            wrapped.mainMenuDidSelect(item: currentItem)
        case _ where itemsToDisplayAdAtEnd.contains(currentItem) && !isPresentingFromStart:
            dismissAfterFinish(from: controller)
        default: return
        }
    }

    private func dismissAfterFinish(from controller: UIViewController?) {
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

    func presenterDidFailToPresentAd(_ presenter: InterstitialPresenter, from controller: UIViewController?) {
        proceedAfterPresentingAd(from: controller)
    }

    func presenterDidDisplayAd(_ presenter: InterstitialPresenter, from controller: UIViewController?) {
        print("Ad displayed")
    }

    func presenterWillDismissAd(_ presenter: InterstitialPresenter, from controller: UIViewController?) {
        proceedAfterPresentingAd(from: controller)
    }

    func presenterDidDismissAd(_ presenter: InterstitialPresenter, from controller: UIViewController?) {
        print("Ad did dismiss")
    }
}

extension MainMenuInterstitialRouterDecorator: AlphabetRouterDelegate {
    func alphabetRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller)
    }
}

extension MainMenuInterstitialRouterDecorator: MemorizeRouterDelegate {
    func memorizeRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller)
    }
}

extension MainMenuInterstitialRouterDecorator: MakeAWordRouterDelegate {
    func makeAWordRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller)
    }
}

extension MainMenuInterstitialRouterDecorator: SubscribeRouterDelegate {
    func subscribeRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.subscribeRouterDidFinishPresenting(controller)
    }
}

extension MainMenuInterstitialRouterDecorator: PicturesRouterDelegate {
    func picturesRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller)
    }
}

extension MainMenuInterstitialRouterDecorator: CatchLetterGameRouterDelegate {
    func catchLetterGameRouterDidFinishPresenting(_ controller: UIViewController) {
        presenter.presentAd(from: controller)
    }
}
