//
//  AlphabetView.swift
//  ABC
//
//  Created by Igor Maisiuk on 19.06.2026.
//

import SwiftUI

struct AlphabetViewSwiftUI: UIViewControllerRepresentable {

    let router: Router

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = router.makeController()
        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {

    }

}

#Preview {
    AlphabetViewSwiftUI(router: DefaultRouterFabric().makeRouter(for: .alphabet))
}
