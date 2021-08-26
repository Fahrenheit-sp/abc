//
//  MakeAWordProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 26.08.21.
//

import Foundation

protocol MakeAWordRoutable: AnyObject, Router {
}

protocol MakeAWordInteractable: AnyObject {
    func didLoad()
}

protocol MakeAWordUserInterface: AnyObject {
    func configure(with model: MakeAWordViewModel)
}
