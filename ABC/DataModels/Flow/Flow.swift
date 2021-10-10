//
//  Flow.swift
//  ABC
//
//  Created by Игорь Майсюк on 10.09.21.
//

import UIKit

protocol Flow: CustomStringConvertible {
    func start(from window: UIWindow?, animated: Bool)
}

extension Flow {

    var description: String {
        String(describing: Self.self)
    }

    func setupRootViewController(_ viewController: UIViewController, in window: UIWindow?, animated: Bool = true) {
        guard window?.rootViewController != viewController else { return }
        func setRootViewController(_ viewController: UIViewController?) {
            window?.rootViewController?.dismiss(animated: false, completion: nil)
            window?.rootViewController = viewController
            window?.makeKeyAndVisible()
        }

        guard animated,
            let snapshot = window?.snapshotView(afterScreenUpdates: true) else {
                setRootViewController(viewController)
                return
        }
        viewController.view.addSubview(snapshot)
        setRootViewController(viewController)
        UIView.animate(withDuration: 0.3, animations: {
            snapshot.layer.opacity = 0
        }, completion: { _ in
            snapshot.removeFromSuperview()
        })
    }
}
