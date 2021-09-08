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

protocol SubscribeRoutable: AnyObject, Router {}

protocol SubscribeInteractable: AnyObject {
    func didLoad()
}

protocol SubscribeUserInterface: AnyObject {
    func configure()
}
