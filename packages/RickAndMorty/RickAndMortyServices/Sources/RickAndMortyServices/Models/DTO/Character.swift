// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

extension DTO {
    struct Character: Codable {
        let id: Int
        let name: String
        let status: Status
        let species: String
        let type: String
        let gender: Gender
        let origin: Location
        let location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
    }

    enum Gender: String, Codable {
        case female = "Female"
        case male = "Male"
        case genderless = "Genderless"
        case unknown = "unknown"
    }

    struct Location: Codable {
        let name: String
        let url: String
    }

    enum Status: String, Codable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
}
