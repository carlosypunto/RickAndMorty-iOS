// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public struct Location {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [Int]
    let created: Date

    public init(
        id: Int,
        name: String,
        type: String,
        dimension: String,
        residents: [Int],
        created: Date
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.dimension = dimension
        self.residents = residents
        self.created = created
    }
}
