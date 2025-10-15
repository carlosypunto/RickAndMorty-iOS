// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

extension DTO {
    struct LocationDTO: Codable {
        let id: Int
        let name: String
        let type: String
        let dimension: String
        let residents: [String]
        let url: String
        let created: String
    }
}
