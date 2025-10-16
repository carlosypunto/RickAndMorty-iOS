// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

extension DTO {
    struct Location: Codable {
        let id: Int
        let name: String
        let type: String
        let dimension: String
        let residents: [String]
        let url: String
        let created: Date
    }
}
