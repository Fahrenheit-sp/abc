//
//  MoreBillingOptionsProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.10.21.
//

import Foundation

import Foundation
import class UIKit.UIViewController

protocol MoreBillingOptionsDelegate: AnyObject {
    func moreOptionsRouterDidFinishPresenting(_ controller: UIViewController)
}

protocol MoreBillingOptionsRoutable: Router {
    func didClose()
}

protocol MoreBillingOptionsInteractable: AnyObject {
    func didLoad()
    func didClose()
    func didSelectSubscription(at index: Int)
    func didPressSubscribe()
}

protocol MoreBillingOptionsUserInterface: AnyObject {
    func configure(with model: MoreBillingOptionsViewModel)
    func didCancelPurchase()
    func didFailPurchase(with message: String)
}
