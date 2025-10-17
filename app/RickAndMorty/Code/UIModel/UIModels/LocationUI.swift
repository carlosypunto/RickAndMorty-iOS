// Copyright (c) 2025 Carlos García Nieto. All rights reserved.
//

import Foundation

public struct LocationUI: Sendable, Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let type: String
    public let dimension: String
    public let residents: [Int]
    public let created: Date

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
