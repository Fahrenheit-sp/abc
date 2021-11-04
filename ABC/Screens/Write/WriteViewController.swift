//
//  WriteViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 1.11.21.
//

import UIKit

final class WriteViewController: UIViewController {

    var interactor: WriteInteractable?

    private let drawView = DrawView().disableAutoresizing()
    private let imageView = UIImageView().disableAutoresizing()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        interactor?.didLoad()
    }

    private func setupUI() {
        view.backgroundColor = .background
        view.addSubview(drawView)
        view.addSubview(imageView)

        imageView.contentMode = .scaleAspectFit

        drawView.onImageGenerated = { [weak self] image in
            self?.imageView.image = image
            self?.view.backgroundColor = image?.averageColor ?? .background
        }

        NSLayoutConstraint.activate([
            drawView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            drawView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            drawView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            drawView.bottomAnchor.constraint(equalTo: view.centerYAnchor),

            imageView.topAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WriteViewController: WriteUserInterface {
    
}
