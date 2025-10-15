// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public struct Character {
    let id: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: String
    let episodes: [Int]
    let url: String
    let created: Date

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
        url: String,
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
        self.url = url
        self.created = created
    }
}

public extension Character {
    enum Gender: String {
        case female
        case male
        case genderless
        case unknown
    }

    struct Location {
        let id: Int
        let name: String

        public init(id: Int, name: String) {
            self.id = id
            self.name = name
        }
    }

    enum Status: String {
        case alive
        case dead
        case unknown
    }
}
