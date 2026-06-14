//
//  Route.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

protocol Route: Hashable { }

protocol Coordinator: ObservableObject {
    associatedtype CoordinatorRoute: Route
    var path: [CoordinatorRoute] { get set }
    func pop()
    func popToRoot()
    func push(_ route: CoordinatorRoute)
    func pop(to route: CoordinatorRoute)
}

extension Coordinator {
    func pop() {
        path.removeLast()
    }

    func popToRoot() {
        path.removeAll()
    }

    func push(_ route: CoordinatorRoute) {
        path.append(route)
    }

    func pop(to route: CoordinatorRoute) {
        while path.last != route && !path.isEmpty {
            path.removeLast()
        }
    }
}

protocol CoordinatorView: View {
    associatedtype CoordinatorType: Coordinator
    var coordinator: CoordinatorType { get }
}
