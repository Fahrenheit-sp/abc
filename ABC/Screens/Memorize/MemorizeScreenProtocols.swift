//
//  MemorizeProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 25.08.21.
//

import Foundation

protocol MemorizeRoutable: AnyObject, Router {
}

protocol MemorizeInteractable: AnyObject {
    func didLoad()
}

protocol MemorizeUserInterface: AnyObject {
    func configure(with model: MemorizeViewModel)
}
