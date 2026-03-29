//
//  Settings.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

final class Settings: ObservableObject {
    @AppStorage("isOnboardingSeen") var isOnboardingSeen = false
}
