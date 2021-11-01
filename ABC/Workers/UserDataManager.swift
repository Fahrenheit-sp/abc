//
//  UserDataManager.swift
//  ABC
//
//  Created by Игорь Майсюк on 9.09.21.
//

import Foundation

struct UserDataManager {
    private let defaults: UserDefaults
    private let key = "com.fahrenheit.abc.userDataKey"

    init(_ defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func save(user: UserData) {
        do {
            let data = try JSONEncoder().encode(user)
            defaults.setValue(data, forKey: key)
            NotificationCenter.default.post(name: .userUpdated, object: nil)
        } catch {
            print("Failed to save user: \(error.localizedDescription)")
        }
    }

    func getUser() -> UserData {
        do {
            guard let data = defaults.data(forKey: key) else { return createNewUser() }
            let user = try JSONDecoder().decode(UserData.self, from: data)
            return user
        } catch {
            print("Failed to fetch user: \(error.localizedDescription)")
            return createNewUser()
        }
    }

    private func createNewUser() -> UserData {
        let data = UserData(expirationDate: nil,
                            lastListenPlayedDate: nil,
                            lastMemorizePlayedDate: nil,
                            lastMakeAWordPlayedDate: nil,
                            lastPicturesPlayedDate: nil,
                            lastWritePlayedDate: nil)
        save(user: data)
        return data
    }
}
