//
//  Settings.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

final class Settings: ObservableObject {
    @AppStorage("isOnboardingSeen") var isOnboardingSeen = false
    @AppStorage("avatar") var avatar = "avatar_main"
    @AppStorage("name") var name = ""
    @AppStorage("musicEnabled") var musicEnabled = false
    @AppStorage("soundsEnabled") var soundsEnabled = false
    @AppStorage("coins_amount") var coins = 0

    var isPremium: Bool {
        #warning("Handle premium")
        false
    }
}

extension Settings {
    static var preview: Settings = {
        let settings = Settings()
        settings.name = "John Doe"
        settings.isOnboardingSeen = true
        settings.coins = 10_000
        return settings
    }()
}
