// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public struct CharacterUI: Sendable, Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let status: Status
    public let species: String
    public let type: String
    public let gender: Gender
    public let origin: Location
    public let location: Location
    public let image: String
    public let episodes: [Int]
    public let created: Date

    public init(
        id: Int,
        name: String,
        status: Status,
        species: String,
        type: String,
        gender: Gender,
        origin: Location,
        location: Location,
        image: String,
        episodes: [Int],
        created: Date
    ) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episodes = episodes
        self.created = created
    }
}

public extension CharacterUI {
    enum Gender: String, Sendable, Equatable {
        case female
        case male
        case genderless
        case unknown
    }

    struct Location: Sendable, Equatable {
        public let id: Int
        public let name: String

        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }

    enum Status: String, Sendable, Equatable {
        case alive
        case dead
        case unknown
    }
}
