//
//  Avatar.swift
//  ABC
//
//  Created by Igor Maisiuk on 14.06.2026.
//


struct Avatar: Hashable, Identifiable, Codable {
    let index: Int

    var name: String {
        "avatar_\(index)"
    }

    var id: Int { index }

    static var avatars: [Avatar] {
        (0..<19).map(Avatar.init)
    }
}
