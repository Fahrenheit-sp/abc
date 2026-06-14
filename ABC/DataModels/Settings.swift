//
//  Settings.swift
//  ABC
//
//  Created by Igor Maisiuk on 29.03.2026.
//

import SwiftUI

final class Settings: ObservableObject {
    private enum Key: String {
        case unlockedAvatars
    }

    private let mainAvatarName = "avatar_0"

    @AppStorage("isOnboardingSeen") var isOnboardingSeen = false
    @AppStorage("avatar") var avatar = "avatar_0"
    @AppStorage("name") var name = ""
    @AppStorage("musicEnabled") var musicEnabled = false
    @AppStorage("soundsEnabled") var soundsEnabled = false
    @AppStorage("coinsAmount") var coins = 0

    var unlockedAvatars: [Avatar] {
        get {
            decode([Avatar].self, for: .unlockedAvatars) ?? [.init(index: 0)]
        }
        set {
            encode(newValue, for: .unlockedAvatars)
        }
    }

    var lockedAvatars: [Avatar] {
        Set(Avatar.avatars).subtracting(Set(unlockedAvatars)).sorted { $0.index < $1.index }
    }

    var isPremium: Bool {
        #warning("Handle premium")
        false
    }

    private func encode<Value: Encodable>(_ value: Value, for key: Key) {
        guard let data = try? JSONEncoder().encode(value) else { return }
        UserDefaults.standard.set(data, forKey: key.rawValue)
    }

    private func decode<Value: Decodable>(_ type: Value.Type, for key: Key) -> Value? {
        guard let data = UserDefaults.standard.data(forKey: key.rawValue) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
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
