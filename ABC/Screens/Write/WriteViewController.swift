//
//  WriteViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 1.11.21.
//

import UIKit

final class WriteViewController: UIViewController {

    var interactor: WriteInteractable?

    private let drawView = DrawView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background

        view.embedSubview(drawView)
    }
}

extension WriteViewController: WriteUserInterface {
    
}
