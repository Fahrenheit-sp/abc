//
//  UIAlertController+Foundation.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import UIKit

protocol AlertPresentable: AnyObject {
    func presentAlert(using model: AlertViewModel)
}

struct AlertViewModel {

    struct Action {

        static let ok = Self.init(title: L10n.General.ok)
        
        let title: String
        let style: UIAlertAction.Style
        let event: (() -> Void)?

        public init(title: String,
                    style: UIAlertAction.Style = .default,
                    event: (() -> Void)? = nil) {
            self.title = title
            self.style = style
            self.event = event
        }
    }

    let title: String?
    let message: String?
    let actions: [Action]

    init(title: String? = L10n.General.error, message: String? = nil, actions: [Action] = [.ok]) {
        self.title = title
        self.message = message
        self.actions = actions
    }

}

extension UIViewController: AlertPresentable {
    func presentAlert(using model: AlertViewModel) {
        let alert = UIAlertController(title: model.title, message: model.message, preferredStyle: .alert)
        model.actions.forEach { action in
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in action.event?() }
            alert.addAction(alertAction)
        }
        present(alert, animated: true, completion: nil)
    }
}
