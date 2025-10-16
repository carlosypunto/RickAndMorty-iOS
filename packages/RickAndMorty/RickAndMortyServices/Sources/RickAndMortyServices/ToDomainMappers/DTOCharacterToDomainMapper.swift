// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

extension DTO.Page<DTO.Character> {
    var toDomain: Page<Character> {
        Page(
            isLast: info.next == nil,
            elements: results.map(\.toDomain)
        )
    }
}

extension DTO.Character {
    var toDomain: Character {
        Character(
            id: id,
            name: name,
            status: status.toDomain,
            species: species,
            type: type,
            gender: gender.toDomain,
            origin: origin.toDomain,
            location: location.toDomain,
            image: image,
            episodes: episode.idsFromURLs,
            created: created
        )
    }
}

extension DTO.Character.Gender {
    var toDomain: Character.Gender {
        switch self {
        case .female: .female
        case .male: .male
        case .genderless: .genderless
        case .unknown: .unknown
        }
    }
}

extension DTO.Character.Location {
    var toDomain: Character.Location {
        let id = Int((URL(string: url)?.lastPathComponent) ?? "0") ?? 0
        return .init(id: id, name: name)
    }
}

extension DTO.Character.Status {
    var toDomain: Character.Status {
        switch self {
        case .alive: .alive
        case .dead: .dead
        case .unknown: .unknown
        }
    }
}
