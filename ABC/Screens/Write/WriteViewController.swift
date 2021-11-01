//
//  WriteViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 1.11.21.
//

import UIKit

final class WriteViewController: UIViewController {

    var interactor: WriteInteractable?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background
    }
}

extension WriteViewController: WriteUserInterface {
    
}
