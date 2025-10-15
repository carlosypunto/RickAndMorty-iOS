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
    }

    enum Status: String {
        case alive
        case dead
        case unknown
    }
}
