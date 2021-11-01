//
//  MainMenuRouterPaywallDecorator.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

final class MainMenuPaywallRouterDecorator: NSObject, MainMenuRoutable {

    private let wrapped: MainMenuRoutable
    private let userManager: UserDataManager
    private let itemsToDisplayPaywall: [MainMenuItem] = [.listen, .memorize, .makeAWord, .pictures]

    init(adaptee: MainMenuRoutable) {
        self.wrapped = adaptee
        self.userManager = UserDataManager()
        super.init()
    }

    func makeController() -> UIViewController {
        let controller = wrapped.makeController()
        setFabricDelegate(to: self)
        setInteractorDelegate(to: self)
        return controller
    }

    func setInteractorDelegate(to router: MainMenuRoutable) {
        wrapped.setInteractorDelegate(to: self)
    }

    func setFabricDelegate(to delegate: MainMenuNavigatable) {
        wrapped.setFabricDelegate(to: delegate)
    }

    func mainMenuDidSelect(item: MainMenuItem) {
        itemsToDisplayPaywall.contains(item) ? showPaywallIfNecessary(for: item) : wrapped.mainMenuDidSelect(item: item)
    }

    private func showPaywallIfNecessary(for item: MainMenuItem) {
        var user = userManager.getUser()
        let now = Date()
        switch item {
        case .listen:
            guard let lastPlayed = user.lastListenPlayedDate, !now.isOneDayPassed(since: lastPlayed) else {
                user.lastListenPlayedDate = now
                userManager.save(user: user)
                wrapped.mainMenuDidSelect(item: item)
                return
            }
            wrapped.mainMenuDidSelect(item: .subscribe)
        case .memorize:
            guard let lastPlayed = user.lastMemorizePlayedDate, !now.isOneDayPassed(since: lastPlayed) else {
                user.lastMemorizePlayedDate = now
                userManager.save(user: user)
                wrapped.mainMenuDidSelect(item: item)
                return
            }
            wrapped.mainMenuDidSelect(item: .subscribe)
        case .makeAWord:
            guard let lastPlayed = user.lastMakeAWordPlayedDate, !now.isOneDayPassed(since: lastPlayed) else {
                user.lastMakeAWordPlayedDate = now
                userManager.save(user: user)
                wrapped.mainMenuDidSelect(item: item)
                return
            }
            wrapped.mainMenuDidSelect(item: .subscribe)
        case .pictures:
            guard let lastPlayed = user.lastPicturesPlayedDate, !now.isOneDayPassed(since: lastPlayed) else {
                user.lastPicturesPlayedDate = now
                userManager.save(user: user)
                wrapped.mainMenuDidSelect(item: item)
                return
            }
            wrapped.mainMenuDidSelect(item: .subscribe)
        case .write:
            guard let lastPlayed = user.lastWritePlayedDate, !now.isOneDayPassed(since: lastPlayed) else {
                user.lastWritePlayedDate = now
                userManager.save(user: user)
                wrapped.mainMenuDidSelect(item: item)
                return
            }
            wrapped.mainMenuDidSelect(item: .subscribe)
        default: return
        }
    }
}

extension MainMenuPaywallRouterDecorator: AlphabetRouterDelegate {
    func alphabetRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.alphabetRouterDidFinishPresenting(controller)
    }
}

extension MainMenuPaywallRouterDecorator: MemorizeRouterDelegate {
    func memorizeRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.memorizeRouterDidFinishPresenting(controller)
    }
}

extension MainMenuPaywallRouterDecorator: MakeAWordRouterDelegate {
    func makeAWordRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.makeAWordRouterDidFinishPresenting(controller)
    }
}

extension MainMenuPaywallRouterDecorator: SubscribeRouterDelegate {
    func subscribeRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.subscribeRouterDidFinishPresenting(controller)
    }
}

extension MainMenuPaywallRouterDecorator: PicturesRouterDelegate {
    func picturesRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.picturesRouterDidFinishPresenting(controller)
    }
}

extension MainMenuPaywallRouterDecorator: WriteRouterDelegate {
    func writeRouterDidFinishPresenting(_ controller: UIViewController) {
        wrapped.writeRouterDidFinishPresenting(controller)
    }
}
