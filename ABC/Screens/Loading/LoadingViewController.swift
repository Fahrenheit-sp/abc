//
//  LoadingViewController.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

final class LoadingViewController: UIViewController {

    private let imageView = UIImageView().disableAutoresizing()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.embedSubview(imageView)

        imageView.contentMode = .scaleAspectFill
        imageView.image = Asset.Menu.background.image
    }
}
