//
//  AlphabetViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 17.08.21.
//

import UIKit

final class AlphabetViewController: UIViewController, AlphabetUserInterface {

    var interactor: AlphabetInteractable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        interactor?.didLoad()
    }

}
