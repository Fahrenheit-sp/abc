//
//  ListenScreenProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 3.09.21.
//

import Foundation

protocol ListenRoutable: AnyObject, Router {}

protocol ListenInteractable: AnyObject {
    func didLoad()
}

protocol ListenUserInterface: AnyObject {
    func configure(with model: ListenViewModel)
}
