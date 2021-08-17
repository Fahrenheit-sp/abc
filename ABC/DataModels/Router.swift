//
//  Router.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import class UIKit.UIViewController

protocol Router {
    func makeController() -> UIViewController
}
