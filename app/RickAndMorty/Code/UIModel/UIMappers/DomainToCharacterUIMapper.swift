// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import RickAndMortyDomain

public extension Character {
    var toUI: CharacterUI {
        CharacterUI(
            id: id,
            name: name,
            status: status.toUI,
            species: species,
            type: type,
            gender: gender.toUI,
            origin: origin.toUI,
            location: location.toUI,
            image: image,
            episodes: episodes,
            created: created
        )
    }
}

public extension Character.Gender {
    var toUI: CharacterUI.Gender {
        switch self {
        case .female: .female
        case .male: .male
        case .genderless: .genderless
        case .unknown: .unknown
        }
    }
}

public extension Character.Location {
    var toUI: CharacterUI.Location {
        CharacterUI.Location(id: id, name: name)
    }
}

public extension Character.Status {
    var toUI: CharacterUI.Status {
        switch self {
        case .alive: .alive
        case .dead: .dead
        case .unknown: .unknown
        }
    }
}
