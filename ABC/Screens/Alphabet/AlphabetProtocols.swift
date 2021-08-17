//
//  AlphabetProtocols.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import Foundation

protocol AlphabetRoutable: AnyObject, Router {
}

protocol AlphabetInteractable: AnyObject {
    func didLoad()
}

protocol AlphabetUserInterface: AnyObject {
}
