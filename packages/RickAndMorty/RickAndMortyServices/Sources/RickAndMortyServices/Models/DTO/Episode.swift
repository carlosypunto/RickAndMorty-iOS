// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

extension DTO {
    struct Episode: Codable {
        let id: Int
        let name: String
        let airDate: String
        let episode: String
        let characters: [String]
        let url: String
        let created: String

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case airDate = "air_date"
            case episode
            case characters
            case url
            case created
        }
    }
}
