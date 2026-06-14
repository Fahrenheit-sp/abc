//
//  HomeRoute.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//

import SwiftUI

enum HomeRoute: Route {
    case profile
    case avatars([Avatar], Bool)
}

final class HomeCoordinator: Coordinator {
    @Published var path: [HomeRoute] = []
}

enum GamesRoute: Route {
    case quiz
    case olympic
}

final class GamesCoordinator: Coordinator {
    @Published var path: [GamesRoute] = []
}
