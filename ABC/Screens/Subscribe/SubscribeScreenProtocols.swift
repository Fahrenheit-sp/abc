//
//  SubscribeScreenProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 8.09.21.
//

import Foundation
import class UIKit.UIViewController

protocol SubscribeRouterDelegate: AnyObject {
    func subscribeRouterDidFinishPresenting(_ controller: UIViewController)
}

protocol SubscribeRoutable: Router {
    func didClose()
    func didTapMoreOptions()
}

protocol SubscribeInteractable: SubscriptionPurchaserDelegate {
    func didLoad()
    func didClose()
    func didRestore()
    func didTapBuyMain()
    func didTapMoreOptions()
}

protocol SubscribeUserInterface: AnyObject {
    func configure(with model: SubscribeScreenViewModel)
    func didCancelPurchase()
    func didFailPurchase(with message: String)
}
