// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation
import RickAndMortyDomain

extension DTO.Page<DTO.Character> {
    var toDomain: RickAndMortyDomain.Page<RickAndMortyDomain.Character> {
        RickAndMortyDomain.Page(
            isLast: info.next == nil,
            elements: results.map(\.toDomain)
        )
    }
}

extension DTO.Character {
    var toDomain: RickAndMortyDomain.Character {
        RickAndMortyDomain.Character(
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
    var toDomain: RickAndMortyDomain.Character.Gender {
        switch self {
        case .female: .female
        case .male: .male
        case .genderless: .genderless
        case .unknown: .unknown
        }
    }
}

extension DTO.Character.Location {
    var toDomain: RickAndMortyDomain.Character.Location {
        let id = Int((URL(string: url)?.lastPathComponent) ?? "0") ?? 0
        return .init(id: id, name: name)
    }
}

extension DTO.Character.Status {
    var toDomain: RickAndMortyDomain.Character.Status {
        switch self {
        case .alive: .alive
        case .dead: .dead
        case .unknown: .unknown
        }
    }
}
