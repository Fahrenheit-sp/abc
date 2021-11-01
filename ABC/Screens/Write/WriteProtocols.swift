//
//  WriteProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 1.11.21.
//

import Foundation

import UIKit

protocol WriteRouterDelegate: AnyObject {
    func writeRouterDidFinishPresenting(_ controller: UIViewController)
}

protocol WriteRoutable: Router {
    func finish()
}

protocol WriteInteractable: AnyObject {
    func didLoad()
}

protocol WriteUserInterface: UIViewController {
    var interactor: WriteInteractable? { get set }
}
